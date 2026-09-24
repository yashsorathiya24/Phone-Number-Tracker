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
        ZStack {
            TrackerTheme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
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
                        Text("Near By Places")
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .foregroundStyle(TrackerTheme.ink)

                        Text("Find essentials around you")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.muted)
                    }

                    Spacer()
                    Color.clear.frame(width: 42, height: 42)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 18)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 22) {
                        ForEach(categories) { category in
                            VStack(alignment: .leading, spacing: 12) {
                                Text(LocalizedStringKey(category.name))
                                    .font(.system(size: 19, weight: .heavy, design: .rounded))
                                    .foregroundStyle(TrackerTheme.ink)
                                    .padding(.horizontal, 4)
                                
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
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
        }
    }
    
    private func placeRow(item: (name: String, emoji: String)) -> some View {
        Button {
            openMap(for: item.name)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                Text(item.emoji)
                    .font(.system(size: 26))
                    .frame(width: 46, height: 46)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                Text(LocalizedStringKey(item.name))
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(TrackerTheme.ink)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 126)
            .background(Color.white.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(TrackerTheme.stroke.opacity(0.85), lineWidth: 1)
            )
            .shadow(color: TrackerTheme.navy.opacity(0.05), radius: 12, x: 0, y: 6)
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
