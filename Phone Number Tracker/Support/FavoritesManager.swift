import Foundation
import Combine

struct FavoriteContact: Codable, Identifiable, Equatable, Hashable {
    var id: String { phoneNumber }
    let name: String?
    let phoneNumber: String
    let location: String
    let countryCode: String
    let carrier: String
}

class FavoritesManager: ObservableObject {
    @Published var favorites: [FavoriteContact] = []
    
    private let defaultsKey = "saved_favorite_contacts"
    
    init() {
        loadFavorites()
    }
    
    func isFavorite(phoneNumber: String) -> Bool {
        return favorites.contains(where: { $0.phoneNumber == phoneNumber })
    }
    
    func toggleFavorite(contact: FavoriteContact) {
        if isFavorite(phoneNumber: contact.phoneNumber) {
            favorites.removeAll { $0.phoneNumber == contact.phoneNumber }
        } else {
            favorites.append(contact)
        }
        saveFavorites()
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: defaultsKey)
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: defaultsKey),
           let decoded = try? JSONDecoder().decode([FavoriteContact].self, from: data) {
            self.favorites = decoded
        }
    }
}
