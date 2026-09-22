import Foundation

struct AreaCodeResponse: Codable {
    let count: Int
    let countries: Int
    let area_codes: [AreaCodeItem]
}

struct AreaCodeItem: Codable, Identifiable {
    var id: String { "\(country_slug)-\(city_slug)-\(area_code)" }
    let country_slug: String
    let city: String
    let city_slug: String
    let area_code: String
    let timezone: String
}
