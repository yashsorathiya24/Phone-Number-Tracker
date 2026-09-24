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
            Map(position: $cameraPosition) {
                UserAnnotation()
            }
            .ignoresSafeArea()

            LinearGradient(
                colors: [
                    TrackerTheme.navy.opacity(0.32),
                    Color.clear,
                    TrackerTheme.teal.opacity(0.14)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 42, height: 42)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 2) {
                        Text("Phone Locator")
                            .font(.system(size: 22, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Search by number")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color.white.opacity(0.78))
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showInfoPopup = true
                        }
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                            .frame(width: 42, height: 42)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Enter a mobile number")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(TrackerTheme.teal)
                        .textCase(.uppercase)

                    HStack(spacing: 10) {
                        Button {
                            showCountryPicker = true
                        } label: {
                            HStack(spacing: 6) {
                                Text(countryService.selectedCountry.flag)
                                    .font(.system(size: 20))
                                Text("+\(countryService.selectedCountry.callingCodes.first ?? "")")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundStyle(TrackerTheme.ink)
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundStyle(TrackerTheme.teal)
                            }
                            .padding(.horizontal, 12)
                            .frame(height: 48)
                            .background(Color(red: 236 / 255, green: 246 / 255, blue: 246 / 255))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        }

                        TextField("Search Phone Number", text: $phoneNumber)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.ink)
                            .keyboardType(.phonePad)

                        Button {
                            startSearch()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 42, height: 42)
                                .background(TrackerTheme.teal)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                    }
                }
                .padding(16)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Carrier")
                       	    .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.muted)
                        Text("Unknown")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(TrackerTheme.ink)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Location")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.muted)
                        Text(countryService.selectedCountry.name)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(TrackerTheme.ink)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .background(Color.white.opacity(0.92))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                )
                .shadow(color: TrackerTheme.navy.opacity(0.12), radius: 18, y: 8)
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
                        .foregroundStyle(TrackerTheme.ink)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Only Phone numbers starting with the proper country code and number format will have their information retrieved.")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundStyle(TrackerTheme.muted)
                        .lineSpacing(4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        withAnimation {
                            showInfoPopup = false
                        }
                    } label: {
                        Text("OK")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.teal)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)
                }
                .padding(24)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
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
