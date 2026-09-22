import Foundation
import Combine

class AreaCodeService: ObservableObject {
    @Published var allAreaCodes: [AreaCodeItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchAreaCodes() {
        guard allAreaCodes.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://telvio.app/api/v1/area-codes.json") else {
            isLoading = false
            errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received."
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(AreaCodeResponse.self, from: data)
                    self?.allAreaCodes = response.area_codes
                } catch {
                    self?.errorMessage = "Failed to decode area codes."
                    print("Area codes decode error: \(error)")
                }
            }
        }.resume()
    }
    
    func filteredCodes(for countryName: String) -> [AreaCodeItem] {
        let slug = generateSlug(from: countryName)
        return allAreaCodes.filter { $0.country_slug == slug }
    }
    
    private func generateSlug(from name: String) -> String {
        let folded = name.folding(options: .diacriticInsensitive, locale: .current)
        let alphanumericsAndSpaces = folded.components(separatedBy: CharacterSet.alphanumerics.union(CharacterSet.whitespaces).inverted).joined()
        let slug = alphanumericsAndSpaces.lowercased().replacingOccurrences(of: " ", with: "-")
        // Clean up consecutive hyphens if any
        return slug.replacingOccurrences(of: "--", with: "-")
    }
}
