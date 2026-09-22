import SwiftUI

struct AreaCodeScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var areaCodeService = AreaCodeService()
    @StateObject private var countryService = CountryService()
    @State private var showCountryPicker = false
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            // Country & Search Bar
            HStack(spacing: 0) {
                // Country Selector
                Button {
                    showCountryPicker = true
                } label: {
                    HStack(spacing: 6) {
                        Text(countryService.selectedCountry.flag)
                            .font(.system(size: 20))
                        Text("+\(countryService.selectedCountry.callingCodes.first ?? "")")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundStyle(.black)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.system(size: 9))
                            .foregroundStyle(Color.blue.opacity(0.6))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
                
                Divider()
                    .frame(height: 24)
                    .background(Color.blue.opacity(0.3))
                
                // Search Field
                HStack {
                    TextField("Search by city", text: $searchText)
                        .font(.system(size: 15, design: .rounded))
                        .foregroundStyle(.black)
                        
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(Color.blue.opacity(0.7))
                }
                .padding(.horizontal, 12)
            }
            .background(Color(red: 240/255, green: 242/255, blue: 246/255))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            // Content
            Group {
                if areaCodeService.isLoading {
                    Spacer()
                    ProgressView()
                        .scaleEffect(1.5)
                    Spacer()
                } else if let errorMessage = areaCodeService.errorMessage {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 40))
                            .foregroundColor(.red)
                        Text(errorMessage)
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.gray)
                        Button("Retry") {
                            areaCodeService.fetchAreaCodes()
                        }
                        .padding(.top, 8)
                    }
                    Spacer()
                } else {
                    let filtered = areaCodeService.filteredCodes(for: countryService.selectedCountry.name).filter { searchText.isEmpty || $0.city.localizedCaseInsensitiveContains(searchText) }
                    if filtered.isEmpty {
                        Spacer()
                        VStack(spacing: 12) {
                            Image(systemName: "map.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.gray.opacity(0.5))
                            Text("No area codes found for \(countryService.selectedCountry.name)")
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(filtered) { item in
                                    AreaCodeRow(item: item, countryName: countryService.selectedCountry.name)
                                }
                            }
                            .padding(20)
                        }
                    }
                }
            }
        }
        .background(Color(red: 245/255, green: 247/255, blue: 250/255).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            areaCodeService.fetchAreaCodes()
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerSheet(countryService: countryService)
        }
    }
    
    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
            }
            
            Text("Area Codes")
                .font(.system(size: 22, weight: .heavy, design: .rounded))
                .foregroundStyle(.black)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(Color.white)
    }
}

struct AreaCodeRow: View {
    let item: AreaCodeItem
    let countryName: String
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.city)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.black)
                
                Text(countryName)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 60/255, green: 110/255, blue: 210/255))
            }
            
            Spacer()
            
            Text(item.area_code)
                .font(.system(size: 18, weight: .heavy, design: .rounded))
                .foregroundStyle(.black)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
    }
}
