import SwiftUI

struct CountryPickerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var countryService: CountryService
    @State private var searchText = ""
    
    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return countryService.countries
        } else {
            return countryService.countries.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.alpha2Code.localizedCaseInsensitiveContains(searchText) ||
                ($0.callingCodes.first ?? "").contains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Select a country")
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.black)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color(white: 0.3))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 16)
            
            // Search Bar
            VStack(spacing: 0) {
                TextField("Search...", text: $searchText)
                    .font(.system(size: 16, design: .rounded))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                
                Divider()
                    .background(Color.black)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 8)
            
            if countryService.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredCountries) { country in
                            Button {
                                countryService.selectedCountry = country
                                dismiss()
                            } label: {
                                HStack(spacing: 12) {
                                    Text(country.flag)
                                        .font(.system(size: 24))
                                    
                                    Text("\(country.name) (\(country.alpha2Code))")
                                        .font(.system(size: 16, design: .rounded))
                                        .foregroundStyle(Color.black)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                    
                                    if let code = country.callingCodes.first {
                                        Text("+\(code)")
                                            .font(.system(size: 16, design: .rounded))
                                            .foregroundStyle(Color.black)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .background(Color.white)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            countryService.fetchCountries()
        }
    }
}
