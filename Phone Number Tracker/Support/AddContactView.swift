import SwiftUI
import ContactsUI

struct AddContactView: UIViewControllerRepresentable {
    let phoneNumber: String
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let contact = CNMutableContact()
        contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: phoneNumber))]
        
        let vc = CNContactViewController(forNewContact: contact)
        vc.delegate = context.coordinator
        
        return UINavigationController(rootViewController: vc)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CNContactViewControllerDelegate {
        var parent: AddContactView
        init(_ parent: AddContactView) { self.parent = parent }
        func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
            viewController.dismiss(animated: true)
        }
    }
}
