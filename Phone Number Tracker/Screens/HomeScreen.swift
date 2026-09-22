//
//  HomeScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct HomeScreen: View {
    var onOpenSettings: () -> Void
    @State private var showProScreen = false
    @State private var showPhoneLocatorSheet = false
    @State private var showContactsSheet = false
    @State private var showNearbySheet = false
    @State private var showGPSToolsSheet = false
    @State private var pendingNumber: String? = nil
    @State private var showLocator = false

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        // Header Section
                        headerSection
                            .padding(.top, 12)

                        // Phone Locator Hero Card
                        heroCard

                        // Quick Tools Section
                        quickToolsSection

                        Spacer(minLength: 28)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationDestination(isPresented: $showProScreen) {
                ProPlanScreen {
                    showProScreen = false
                }
                .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $showPhoneLocatorSheet) {
                PhoneLocatorScreen()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .navigationDestination(isPresented: $showContactsSheet) {
                ContactsScreen(onSelectNumber: { number in
                                pendingNumber = number
                                showLocator = true          // present locator right after
                            })
                
                    .toolbar(.hidden, for: .navigationBar)
            }
            .navigationDestination(isPresented: $showNearbySheet) {
                NearbyPlacesScreen()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .navigationDestination(isPresented: $showGPSToolsSheet) {
                GPSToolsSheet()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .navigationDestination(for: FavoriteContact.self) { fav in
                PhoneDetailsScreen(
                    contactName: fav.name,
                    phoneNumber: fav.phoneNumber,
                    location: fav.location,
                    countryCode: fav.countryCode,
                    carrier: fav.carrier
                )
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }

    // MARK: - Header
    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text("Hi there")
                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color(red: 20 / 255, green: 22 / 255, blue: 28 / 255))

                    Text("👋")
                        .font(.system(size: 26))
                }

                Text("Track numbers and manage your favorite tools")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 130 / 255, green: 134 / 255, blue: 145 / 255))
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 12)

            HStack(spacing: 12) {
                // Crown PRO Button
                Button {
                    showProScreen = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 50 / 255, green: 140 / 255, blue: 250 / 255),
                                        Color(red: 30 / 255, green: 110 / 255, blue: 235 / 255)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 42, height: 42)
                            .shadow(color: Color.blue.opacity(0.25), radius: 4, x: 0, y: 2)

                        Image(systemName: "crown.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 255 / 255, green: 235 / 255, blue: 85 / 255),
                                        Color(red: 255 / 255, green: 195 / 255, blue: 35 / 255)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                }
                .buttonStyle(.plain)

                // Settings Gear Button
                Button(action: onOpenSettings) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color(red: 24 / 255, green: 26 / 255, blue: 32 / 255))
                        .frame(width: 42, height: 42)
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: - Hero Card
    private var heroCard: some View {
        Button {
            showPhoneLocatorSheet = true
        } label: {
            ZStack(alignment: .bottomTrailing) {
                HStack(alignment: .center, spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Phone Locator")
                            .font(.system(size: 23, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Pinpoint any phone number\non the map.")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundStyle(Color.white.opacity(0.92))
                            .lineSpacing(2)

                        Button {
                            showPhoneLocatorSheet = true
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 14, weight: .bold))

                                Text("Locate now")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                            }
                            .foregroundStyle(Color(red: 30 / 255, green: 120 / 255, blue: 240 / 255))
                            .padding(.horizontal, 18)
                            .frame(height: 38)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 4)
                    }

                    Spacer(minLength: 0)

                    // Phone Locator Illustration Artwork
                    Image("ic_locator")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .offset(x: 6, y: 4)
                }
                .padding(.leading, 20)
                .padding(.trailing, 10)
                .padding(.vertical, 22)
            }
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 255 / 255, green: 82 / 255, blue: 142 / 255),
                        Color(red: 135 / 255, green: 90 / 255, blue: 248 / 255)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            .shadow(color: Color(red: 255 / 255, green: 82 / 255, blue: 142 / 255).opacity(0.28), radius: 14, x: 0, y: 7)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Quick Tools
    private var quickToolsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Quick tools")
                .font(.system(size: 21, weight: .heavy, design: .rounded))
                .foregroundStyle(Color(red: 22 / 255, green: 24 / 255, blue: 30 / 255))

            HStack(spacing: 12) {
                QuickToolCard(
                    icon: Image("ic_contact")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 58, height: 58),
                    title: "My\nContacts",
                    subtitle: "Access\nyour saved\ncontacts."
                ) {
                    showContactsSheet = true
                }

                QuickToolCard(
                    icon: Image("ic_nearby")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 58, height: 58),
                    title: "Near By\nPlaces",
                    subtitle: "Find nearby\nservices\ninstantly."
                ) {
                    showNearbySheet = true
                }

                QuickToolCard(
                    icon: Image("ic_gpstool")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 58, height: 58),
                    title: "GPS\nTools",
                    subtitle: "Compass,\nlevel, codes\n& more."
                ) {
                    showGPSToolsSheet = true
                }
            }
        }
    }
}

// MARK: - Interactive Feature Sheets



struct GPSToolsSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTool: String?
    @State private var showCompass = false
    @State private var showSpeedometer = false
    @State private var showStopwatch = false
    @State private var showLevelMeter = false

    var body: some View {
        VStack(spacing: 0) {
            // Top Header
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

                Text("GPS Tools")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 40 / 255, green: 42 / 255, blue: 50 / 255))
                    .offset(x: -8) // center visually

                Spacer()

                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 20)

            // Tools List
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    gpsToolRow(
                        title: "Compass",
                        icon: AnyView(
                            Image("ic_compass")
                                .resizable()
                                .scaledToFit()
                        )
                    )

                    gpsToolRow(
                        title: "Speedometer",
                        icon: AnyView(
                            Image("ic_speedometer")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(1.4)
                        )
                    )

                    gpsToolRow(
                        title: "Level Meter",
                        icon: AnyView(
                            Image("ic_levelmeter")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(1.35)
                        )
                    )

                    gpsToolRow(
                        title: "Area Codes",
                        icon: AnyView(
                            Image("ic_areacodes")
                                .resizable()
                                .scaledToFit()
                        )
                    )

                    gpsToolRow(
                        title: "Stopwatch",
                        icon: AnyView(
                            Image("ic_stopwatch")
                                .resizable()
                                .scaledToFit()
                        )
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationDestination(isPresented: $showCompass) {
            CompassScreen()
        }
        .navigationDestination(isPresented: $showSpeedometer) {
            SpeedometerScreen()
        }
        .navigationDestination(isPresented: $showStopwatch) {
            StopwatchScreen()
        }
        .navigationDestination(isPresented: $showLevelMeter) {
            LevelMeterScreen()
        }
        .sheet(item: Binding<IdentifiableString?>(
            get: { selectedTool.map { IdentifiableString($0) } },
            set: { selectedTool = $0?.value }
        )) { tool in
            GPSToolDetailSheet(toolName: tool.value)
        }
    }

    private func gpsToolRow(title: String, icon: AnyView) -> some View {
        Button {
            if title == "Compass" {
                showCompass = true
            } else if title == "Speedometer" {
                showSpeedometer = true
            } else if title == "Stopwatch" {
                showStopwatch = true
            } else if title == "Level Meter" {
                showLevelMeter = true
            } else {
                selectedTool = title
            }
        } label: {
            HStack(spacing: 16) {
                icon
                    .frame(width: 32, height: 32)

                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.black.opacity(0.85))

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
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
}

// MARK: - Helpers

private struct IdentifiableString: Identifiable {
    let id = UUID()
    let value: String
    init(_ v: String) { value = v }
}

struct GPSToolDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    let toolName: String

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Image(systemName: toolIconName)
                    .font(.system(size: 72))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255),
                                Color(red: 25 / 255, green: 90 / 255, blue: 225 / 255)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(.top, 30)

                VStack(spacing: 8) {
                    Text(toolName)
                        .font(.system(size: 24, weight: .bold, design: .rounded))

                    Text(toolDescription)
                        .font(.system(size: 15, design: .rounded))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }

                Spacer()
            }
            .navigationTitle(toolName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    private var toolIconName: String {
        switch toolName {
        case "Compass":     return "location.north.circle.fill"
        case "Speedometer": return "gauge.with.needle"
        case "Level Meter": return "ruler.fill"
        case "Area Codes":  return "map.fill"
        default:            return "stopwatch.fill"
        }
    }

    private var toolDescription: String {
        switch toolName {
        case "Compass":     return "Shows your current heading using the device magnetometer."
        case "Speedometer": return "Displays your real-time speed using GPS."
        case "Level Meter": return "Use your device as a bubble level on any surface."
        case "Area Codes":  return "Look up country and STD area codes worldwide."
        default:            return "Track elapsed time with precision."
        }
    }
}

#Preview {
    HomeScreen(onOpenSettings: {})
}
