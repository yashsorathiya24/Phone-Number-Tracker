import SwiftUI

struct NearbyPlacesScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    struct PlaceCategory: Identifiable {
        let id = UUID()
        let name: String
        let items: [(name: String, emoji: String)]
    }
    
    let categories: [PlaceCategory] = [
        PlaceCategory(name: "Education", items: [
            ("School", "🏫"),
            ("University", "🏛️")
        ]),
        PlaceCategory(name: "Food Point", items: [
            ("Restaurant", "🍽️"),
            ("Bakery", "🥐"),
            ("Bar", "🍻"),
            ("Pizza Shop", "🍕"),
            ("Cafe Shop", "☕")
        ]),
        PlaceCategory(name: "Shopping", items: [
            ("Department", "🏬"),
            ("Electronic Store", "💻"),
            ("Flower Shop", "💐"),
            ("Hardware Store", "🛠️")
        ]),
        PlaceCategory(name: "Service", items: [
            ("Car Rental", "🚗"),
            ("Workshop", "🧑‍🔧"),
            ("ATM", "🏧"),
            ("Car Wash", "🧽"),
            ("Car Repair", "🔧"),
            ("Shoe Shop", "👞")
        ]),
        PlaceCategory(name: "Office", items: [
            ("Accountant", "🧾"),
            ("Bank", "🏦"),
            ("Airport", "✈️"),
            ("Govt Office", "🏛️")
        ]),
        PlaceCategory(name: "Health", items: [
            ("Hospital", "🏥"),
            ("Pharmacy", "💊"),
            ("Doctor", "👨‍⚕️"),
            ("Dentist", "🦷")
        ]),
        PlaceCategory(name: "Worship Place", items: [
            ("Mosque", "🕌"),
            ("Church", "⛪"),
            ("Temple", "🛕"),
            ("Worship Place", "🛐")
        ])
    ]
    
    var body: some View {
        VStack(spacing: 0) {
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
                
                Text("Near By Places")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 40 / 255, green: 42 / 255, blue: 50 / 255))
                    .offset(x: -8) // visual center
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 16)
            
            // List
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(categories) { category in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(category.name)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.black)
                                .padding(.horizontal, 4)
                            
                            VStack(spacing: 12) {
                                ForEach(category.items, id: \.name) { item in
                                    placeRow(item: item)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    private func placeRow(item: (name: String, emoji: String)) -> some View {
        Button {
            openMap(for: item.name)
        } label: {
            HStack(spacing: 16) {
                Text(item.emoji)
                    .font(.system(size: 28))
                    .frame(width: 40, height: 40)
                
                Text(item.name)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.black.opacity(0.85))
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(height: 72)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color(red: 235 / 255, green: 238 / 255, blue: 245 / 255), lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
    
    private func openMap(for query: String) {
        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "maps://?q=\(encodedQuery)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
