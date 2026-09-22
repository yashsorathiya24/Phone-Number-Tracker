import SwiftUI
import MapKit
import Contacts

struct PhoneLocatorScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var countryService = CountryService()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var contactManager = ContactManager()
    
    @State private var phoneNumber = ""
    @State private var showCountryPicker = false
    @State private var showInfoPopup = false
    @State private var isSearching = false
    @State private var showDetails = false
    @State private var searchedContactName: String? = nil
    var initialPhoneNumber: String? = nil               // ← add this

    // Map state for the background
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629), // India as default
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    ))
    
    var body: some View {
        ZStack {
            // Background Map
            Map(position: $cameraPosition) {
                UserAnnotation()
            }
            .ignoresSafeArea()
            
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
                    
                    Text("Phone Locator")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 40 / 255, green: 42 / 255, blue: 50 / 255))
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showInfoPopup = true
                        }
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 22))
                            .foregroundStyle(Color.black)
                    }
                    .frame(width: 44, height: 44)
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 16)
                .background(Color(white: 0.94).opacity(0.95))
                
                // Search Bar
                HStack(spacing: 0) {
                    Button {
                        showCountryPicker = true
                    } label: {
                        HStack(spacing: 6) {
                            Text(countryService.selectedCountry.flag)
                                .font(.system(size: 20))
                            Text("+\(countryService.selectedCountry.callingCodes.first ?? "")")
                                .font(.system(size: 16, design: .rounded))
                                .foregroundStyle(Color.black)
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.system(size: 10))
                                .foregroundStyle(Color.blue)
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 50)
                    }
                    
                    Divider()
                        .frame(height: 24)
                        .background(Color.gray.opacity(0.3))
                    
                    TextField("Search Phone Number", text: $phoneNumber)
                        .font(.system(size: 16, design: .rounded))
                        .foregroundStyle(Color.black)
                        .padding(.horizontal, 12)
                        .frame(height: 50)
                    
                    Button {
                        startSearch()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundStyle(Color(red: 160 / 255, green: 170 / 255, blue: 210 / 255))
                            .padding(.trailing, 16)
                    }
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                // Result Card (Always visible directly below search)
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Carrier")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.black)
                        Text("Unknown")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(red: 45 / 255, green: 110 / 255, blue: 210 / 255))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Location")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.black)
                        Text(countryService.selectedCountry.name)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(red: 45 / 255, green: 110 / 255, blue: 210 / 255))
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: Color.black.opacity(0.1), radius: 10, y: 5)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                Spacer()
            }
            
            // Info Popup Overlay
            if showInfoPopup {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showInfoPopup = false
                        }
                    }
                
                VStack(spacing: 20) {
                    Text("Phone Locator")
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Only Phone numbers starting with the proper country code and number format will have their information retrieved.")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundStyle(Color(white: 0.2))
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        withAnimation {
                            showInfoPopup = false
                        }
                    } label: {
                        Text("OK")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(red: 100 / 255, green: 80 / 255, blue: 150 / 255)) // purple
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)
                }
                .padding(24)
                .background(Color(red: 242 / 255, green: 238 / 255, blue: 250 / 255)) // Light purplish background matching screenshot
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 40)
                .shadow(color: Color.black.opacity(0.15), radius: 20)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerSheet(countryService: countryService)
                .presentationDetents([.fraction(0.85), .large])
                .presentationDragIndicator(.visible)
        }
        .onChange(of: locationManager.location) { newLocation in
            if let loc = newLocation {
                withAnimation {
                    cameraPosition = .region(MKCoordinateRegion(
                        center: loc.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    ))
                }
            }
        }
        .onAppear {
            if contactManager.permissionStatus == .notDetermined {
                contactManager.requestPermission()
            } else if contactManager.permissionStatus == .authorized {
                contactManager.fetchContacts()
            }
            if let initial = initialPhoneNumber, phoneNumber.isEmpty {
                phoneNumber = initial
                startSearch()
            }
        }
        .navigationDestination(isPresented: $showDetails) {
            PhoneDetailsScreen(
                contactName: searchedContactName,
                phoneNumber: phoneNumber,
                location: countryService.selectedCountry.name,
                countryCode: countryService.selectedCountry.alpha2Code,
                carrier: "Unknown"
            )
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func startSearch() {
        guard !phoneNumber.isEmpty else { return }
        
        let foundContact = contactManager.findContact(by: phoneNumber)
        searchedContactName = foundContact?.name
        
        // Show details screen
        showDetails = true
    }
}
