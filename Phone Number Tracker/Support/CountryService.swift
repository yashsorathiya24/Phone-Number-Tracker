import Foundation
import Combine

struct Country: Codable, Identifiable {
    var id: String { alpha2Code }
    let name: String
    let alpha2Code: String
    let flag: String
    let callingCodes: [String]
}

class CountryService: ObservableObject {
    @Published var countries: [Country] = []
    @Published var isLoading = false
    
    // Default country (India) for initial state matching the screenshot
    @Published var selectedCountry: Country = Country(
        name: "India",
        alpha2Code: "IN",
        flag: "🇮🇳",
        callingCodes: ["91"]
    )
    
    func fetchCountries() {
        guard countries.isEmpty else { return } // Avoid refetching if already loaded
        
        isLoading = true
        let urlString = "https://countries.dev/countries?fields=name%2Calpha2Code%2Cflag%2CcallingCodes&sort=name"
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                guard let data = data, error == nil else {
                    print("Error fetching countries: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    let decodedCountries = try JSONDecoder().decode([Country].self, from: data)
                    // Filter out any entries without a calling code
                    self?.countries = decodedCountries.filter { !$0.callingCodes.isEmpty && !$0.callingCodes[0].isEmpty }
                } catch {
                    print("Failed to decode countries: \(error)")
                }
            }
        }.resume()
    }
}
