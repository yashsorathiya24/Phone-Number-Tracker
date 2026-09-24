import SwiftUI

struct PhoneDetailsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    @State private var showAddContact = false
    
    let contactName: String?
    let phoneNumber: String
    let location: String
    let countryCode: String
    let carrier: String
    
    // Derived property for the combined display name
    private var displayName: String {
        if let name = contactName, !name.isEmpty {
            return "\(name) - \(phoneNumber)"
        } else {
            return "Unknown - \(phoneNumber)"
        }
    }
    
    // Check if the current contact is favorited
    private var isFavorite: Bool {
        favoritesManager.isFavorite(phoneNumber: phoneNumber)
    }
    
    // Create the favorite contact model
    private var favoriteModel: FavoriteContact {
        FavoriteContact(
            name: contactName,
            phoneNumber: phoneNumber,
            location: location,
            countryCode: countryCode,
            carrier: carrier
        )
    }
    
    var body: some View {
        ZStack {
            TrackerTheme.background
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
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
                        Text("Details")
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .foregroundStyle(TrackerTheme.ink)

                        Text("Saved lookup")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.muted)
                    }
                    
                    Spacer()
                    
                    Color.clear.frame(width: 42, height: 42)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                VStack(spacing: 20) {
                    ZStack(alignment: .topTrailing) {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.16))
                                    .frame(width: 132, height: 132)

                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 96, height: 96)

                                Image(systemName: "person.fill")
                                    .font(.system(size: 46, weight: .semibold))
                                    .foregroundStyle(TrackerTheme.teal)
                            }
                            .padding(.top, 22)

                            VStack(spacing: 8) {
                                Text(displayName)
                                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 20)
                                    .multilineTextAlignment(.center)

                                HStack(spacing: 8) {
                                    Image(systemName: "mappin.and.ellipse")
                                    Text(location)
                                }
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color.white.opacity(0.85))
                                .lineLimit(1)
                            }
                            .padding(.bottom, 24)
                        }
                        .frame(maxWidth: .infinity)

                        Button {
                            withAnimation {
                                favoritesManager.toggleFavorite(contact: favoriteModel)
                            }
                        } label: {
                            Image(systemName: isFavorite ? "star.fill" : "star.fill")
                                .font(.system(size: 23))
                                .foregroundStyle(isFavorite ? TrackerTheme.amber : Color.white.opacity(0.54))
                                .frame(width: 46, height: 46)
                                .background(Color.white.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        }
                        .padding(18)
                    }
                    .background(
                        LinearGradient(
                            colors: [
                                TrackerTheme.navy,
                                TrackerTheme.indigo,
                                TrackerTheme.teal
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))

                    VStack(spacing: 24) {
                        detailRow(icon: "phone.circle.fill", title: "Mobile", value: phoneNumber)
                        detailRow(icon: "mappin.circle.fill", title: "Location", value: location)
                        detailRow(icon: "globe", title: "Country Code", value: countryCode)
                        detailRow(icon: "phone.fill", title: "Carrier", value: carrier)
                    }
                    .padding(22)
                }
                .background(Color.white.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: TrackerTheme.navy.opacity(0.08), radius: 18, x: 0, y: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(TrackerTheme.stroke.opacity(0.9), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                
                HStack(spacing: 16) {
                    actionButton(title: "Call", icon: "phone.fill", color: TrackerTheme.teal) {
                        let formattedNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        if let url = URL(string: "tel://\(formattedNumber)") {
                            UIApplication.shared.open(url)
                        }
                    }
                    actionButton(title: "SMS", icon: "message.fill", color: TrackerTheme.amber) {
                        let formattedNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        if let url = URL(string: "sms://\(formattedNumber)") {
                            UIApplication.shared.open(url)
                        }
                    }
                    actionButton(title: "Add", icon: "person.badge.plus", color: TrackerTheme.indigo) {
                        showAddContact = true
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .shadow(color: TrackerTheme.navy.opacity(0.06), radius: 16, x: 0, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(TrackerTheme.stroke.opacity(0.9), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showAddContact) {
            AddContactView(phoneNumber: phoneNumber)
        }
    }
    
    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundStyle(TrackerTheme.teal)
                .frame(width: 44, height: 44)
                .background(Color(red: 236 / 255, green: 246 / 255, blue: 246 / 255))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(TrackerTheme.muted)
                
                Text(value)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundStyle(TrackerTheme.ink)
            }
            
            Spacer()
        }
    }
    
    private func actionButton(title: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .bold))

                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 64)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
