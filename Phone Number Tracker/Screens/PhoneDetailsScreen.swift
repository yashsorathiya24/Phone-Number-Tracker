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
            Color(red: 247/255, green: 248/255, blue: 255/255)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Header
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
                    
                    Text("Details")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.horizontal, 16)
                
                // Main Card
                VStack(spacing: 0) {
                    // Top colored header section of the card
                    ZStack(alignment: .topTrailing) {
                        // Light blue header background
                        Rectangle()
                            .fill(Color(red: 235/255, green: 240/255, blue: 255/255))
                            .frame(height: 100)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 24,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 24
                                )
                            )
                        
                        // Favorite Star Button
                        Button {
                            withAnimation {
                                favoritesManager.toggleFavorite(contact: favoriteModel)
                            }
                        } label: {
                            Image(systemName: isFavorite ? "star.fill" : "star.fill")
                                .font(.system(size: 28))
                                .foregroundStyle(isFavorite ? Color(red: 255/255, green: 195/255, blue: 0) : Color(white: 0.7))
                        }
                        .padding(20)
                    }
                    
                    // Avatar overlap
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 100, height: 100)
                            .shadow(color: Color.black.opacity(0.05), radius: 10)
                        
                        Circle()
                            .fill(Color(red: 240/255, green: 245/255, blue: 255/255))
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(Color.blue)
                    }
                    .offset(y: -50)
                    .padding(.bottom, -30)
                    
                    // Title and Info
                    Text(displayName)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.black)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    
                    Divider()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                    
                    // Details List
                    VStack(spacing: 24) {
                        detailRow(icon: "phone.circle.fill", title: "Mobile", value: phoneNumber)
                        detailRow(icon: "mappin.circle.fill", title: "Location", value: location)
                        detailRow(icon: "globe", title: "Country Code", value: countryCode) // Using globe as a proxy for the ISO icon
                        detailRow(icon: "phone.fill", title: "Carrier", value: carrier)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: Color.black.opacity(0.05), radius: 15, x: 0, y: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                
                // Bottom Actions Card
                HStack(spacing: 16) {
                    actionButton(title: "Call", color: Color(red: 20/255, green: 200/255, blue: 100/255)) {
                        let formattedNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        if let url = URL(string: "tel://\(formattedNumber)") {
                            UIApplication.shared.open(url)
                        }
                    }
                    actionButton(title: "SMS", color: Color(red: 250/255, green: 180/255, blue: 20/255)) {
                        let formattedNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                        if let url = URL(string: "sms://\(formattedNumber)") {
                            UIApplication.shared.open(url)
                        }
                    }
                    actionButton(title: "Add", color: Color(red: 80/255, green: 150/255, blue: 250/255)) {
                        showAddContact = true
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: Color.black.opacity(0.05), radius: 15, x: 0, y: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
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
                .font(.system(size: 24))
                .foregroundStyle(Color(red: 80/255, green: 120/255, blue: 220/255))
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.gray)
                
                Text(value)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.black)
            }
            
            Spacer()
        }
    }
    
    private func actionButton(title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(color)
                .clipShape(Capsule())
        }
    }
}
