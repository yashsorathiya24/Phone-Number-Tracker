import Foundation
import Contacts
import SwiftUI
import Combine

class ContactManager: ObservableObject {
    @Published var contacts: [ContactInfo] = []
    @Published var permissionStatus: CNAuthorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
    
    private let store = CNContactStore()
    
    struct ContactInfo: Identifiable {
        let id = UUID()
        let name: String
        let phoneNumber: String
    }
    
    func requestPermission() {
        store.requestAccess(for: .contacts) { [weak self] granted, error in
            DispatchQueue.main.async {
                self?.permissionStatus = CNContactStore.authorizationStatus(for: .contacts)
                if granted {
                    self?.fetchContacts()
                }
            }
        }
    }
    
    func fetchContacts() {
        guard CNContactStore.authorizationStatus(for: .contacts) == .authorized else { return }
        
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        var fetchedContacts: [ContactInfo] = []
        
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                // Only get contacts with phone numbers
                guard let firstPhoneNumber = contact.phoneNumbers.first?.value.stringValue else { return }
                
                let firstName = contact.givenName
                let lastName = contact.familyName
                var fullName = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
                
                if fullName.isEmpty {
                    fullName = firstPhoneNumber
                }
                
                let contactInfo = ContactInfo(
                    name: fullName,
                    phoneNumber: firstPhoneNumber
                )
                fetchedContacts.append(contactInfo)
            }
            
            DispatchQueue.main.async {
                self.contacts = fetchedContacts.sorted { $0.name.lowercased() < $1.name.lowercased() }
            }
        } catch {
            print("Failed to fetch contacts, error: \(error)")
        }
    }
    
    func findContact(by phoneNumber: String) -> ContactInfo? {
        let normalizedSearch = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return contacts.first { contact in
            let normalizedContact = contact.phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            // Check if one contains the other to handle country code prefix differences
            return !normalizedSearch.isEmpty && !normalizedContact.isEmpty && 
                   (normalizedContact.contains(normalizedSearch) || normalizedSearch.contains(normalizedContact))
        }
    }
}
