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
        ZStack {
            TrackerTheme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 10) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(TrackerTheme.ink)
                                .frame(width: 42, height: 42)
                                .background(Color.white.opacity(0.82))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }

                        Spacer()

                        VStack(spacing: 2) {
                            Text("My Contacts")
                                .font(.system(size: 24, weight: .heavy, design: .rounded))
                                .foregroundStyle(TrackerTheme.ink)

                            Text("All your friends organized.")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .foregroundStyle(TrackerTheme.muted)
                        }

                        Spacer()
                        Color.clear.frame(width: 42, height: 42)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 18)

                if contactManager.permissionStatus == .authorized {
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(TrackerTheme.teal)

                        TextField("Search by name", text: $searchText)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.ink)
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 54)
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(TrackerTheme.stroke.opacity(0.9), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 18)

                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
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
                    Spacer()

                    VStack(spacing: 24) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .fill(Color.white.opacity(0.9))
                                .frame(width: 94, height: 94)

                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                .font(.system(size: 40, weight: .semibold))
                                .foregroundStyle(TrackerTheme.coral)
                        }

                        Text("Contact permission is needed to look up saved names.")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.muted)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }

                    Spacer()
                    Spacer()
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
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
                .foregroundStyle(TrackerTheme.teal)
            Spacer()
        }
        .padding(.vertical, 8)
        .background(TrackerTheme.background)
    }

    private func contactRow(contact: ContactManager.ContactInfo) -> some View {
        Button {
            onSelectNumber(contact.phoneNumber)   // just report selection — don't dismiss here
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color(red: 235 / 255, green: 246 / 255, blue: 246 / 255))
                        .frame(width: 50, height: 50)

                    Image(systemName: "person.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(TrackerTheme.teal)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(contact.name)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(TrackerTheme.ink)

                    Text(contact.phoneNumber)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundStyle(TrackerTheme.muted)
                }

                Spacer()

                if favoritesManager.isFavorite(phoneNumber: contact.phoneNumber) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(TrackerTheme.amber)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(TrackerTheme.stroke.opacity(0.8), lineWidth: 1)
            )
            .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
