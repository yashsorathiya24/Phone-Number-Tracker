import SwiftUI
import Contacts

struct ContactsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var favoritesManager: FavoritesManager
    @StateObject private var contactManager = ContactManager()
    @State private var searchText = ""
    var onSelectNumber: (String) -> Void = { _ in }   // ← add this

    
    var filteredContacts: [ContactManager.ContactInfo] {
        if searchText.isEmpty {
            return contactManager.contacts
        } else {
            return contactManager.contacts.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.phoneNumber.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var groupedContacts: [(String, [ContactManager.ContactInfo])] {
        let grouped = Dictionary(grouping: filteredContacts) { contact -> String in
            let firstChar = contact.name.first?.uppercased() ?? "#"
            let letterRegex = "^[A-Z]$"
            if firstChar.range(of: letterRegex, options: .regularExpression) != nil {
                return firstChar
            }
            return "#"
        }
        // Sort keys: A-Z first, then "#"
        return grouped.sorted {
            if $0.key == "#" { return false }
            if $1.key == "#" { return true }
            return $0.key < $1.key
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 8) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.black)
                    }
                    .frame(width: 44, height: 44)

                    Spacer()

                    Text("My Contacts")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.black)
                        .offset(x: -8) // visual center

                    Spacer()

                    Color.clear.frame(width: 44, height: 44)
                }

                Text("All your friends organized.")
                    .font(.system(size: 15, design: .rounded))
                    .foregroundStyle(Color.gray)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 16)

            if contactManager.permissionStatus == .authorized {
                // Search Bar
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.blue)

                    TextField("Search by name", text: $searchText)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.black)
                }
                .padding(.horizontal, 16)
                .frame(height: 50)
                .background(Color(white: 0.94))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                // List
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(groupedContacts, id: \.0) { section in
                            Section(header: sectionHeader(title: section.0)) {
                                ForEach(section.1) { contact in
                                    contactRow(contact: contact)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            } else if contactManager.permissionStatus == .denied || contactManager.permissionStatus == .restricted {
                // Denied State
                Spacer()

                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 235 / 255, green: 238 / 255, blue: 255 / 255))
                            .frame(width: 90, height: 90)

                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(red: 100 / 255, green: 110 / 255, blue: 180 / 255)) // Muted purple/blue matching screenshot
                    }

                    Text("Contact permission is needed to look up saved names.")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                Spacer()
                Spacer()
            } else {
                // Not Determined or Loading
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            if contactManager.permissionStatus == .notDetermined {
                contactManager.requestPermission()
            } else if contactManager.permissionStatus == .authorized {
                contactManager.fetchContacts()
            }
        }
    }

    private func sectionHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 160 / 255, green: 165 / 255, blue: 175 / 255))
            Spacer()
        }
        .padding(.vertical, 8)
        .background(Color.white) // Solid background for sticky header
    }

    private func contactRow(contact: ContactManager.ContactInfo) -> some View {
        Button {
            onSelectNumber(contact.phoneNumber)   // just report selection — don't dismiss here
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color(red: 235 / 255, green: 240 / 255, blue: 255 / 255))
                        .frame(width: 48, height: 48)

                    Image(systemName: "person.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(contact.name)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.black)

                    Text(contact.phoneNumber)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundStyle(Color.gray)
                }

                Spacer()

                if favoritesManager.isFavorite(phoneNumber: contact.phoneNumber) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                }
            }
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
