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
                TrackerTheme.background
                    .ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        headerSection
                            .padding(.top, 18)

                        heroCard

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
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                Text("Hi there")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(TrackerTheme.teal)
                    .textCase(.uppercase)

                Spacer(minLength: 12)

                Button {
                    showProScreen = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        TrackerTheme.coral,
                                        TrackerTheme.amber
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 42, height: 42)
                            .shadow(color: TrackerTheme.coral.opacity(0.24), radius: 10, x: 0, y: 5)

                        Image(systemName: "crown.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)

                Button(action: onOpenSettings) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundStyle(TrackerTheme.ink)
                        .frame(width: 42, height: 42)
                        .background(.white.opacity(0.78))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(TrackerTheme.stroke.opacity(0.75), lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }

            Text(LocalizedStringKey("Track numbers and manage your favorite tools"))
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundStyle(TrackerTheme.ink)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - Hero Card
    private var heroCard: some View {
        Button {
            showPhoneLocatorSheet = true
        } label: {
            ZStack(alignment: .bottomTrailing) {
                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 18)
                    .frame(width: 190, height: 190)
                    .offset(x: 70, y: 64)

                HStack(alignment: .center, spacing: 12) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Phone Locator")
                            .font(.system(size: 30, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)

                        Text("Pinpoint any phone number on the map.")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(Color.white.opacity(0.92))
                            .lineSpacing(2)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)

                        Button {
                            showPhoneLocatorSheet = true
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 14, weight: .bold))

                                Text("Locate now")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                            }
                            .foregroundStyle(TrackerTheme.navy)
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

                    Image("ic_locator")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 132, height: 132)
                        .padding(12)
                        .background(Color.white.opacity(0.14))
                        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                        .offset(x: 8, y: 5)
                }
                .padding(.leading, 20)
                .padding(.trailing, 12)
                .padding(.vertical, 24)
            }
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [
                        TrackerTheme.navy,
                        TrackerTheme.indigo,
                        TrackerTheme.teal
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: TrackerTheme.navy.opacity(0.22), radius: 18, x: 0, y: 10)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Quick Tools
    private var quickToolsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Quick tools")
                .font(.system(size: 21, weight: .heavy, design: .rounded))
                .foregroundStyle(TrackerTheme.ink)

            VStack(spacing: 12) {
                QuickToolCard(
                    icon: Image("ic_contact")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54),
                    title: "My Contacts",
                    accent: TrackerTheme.teal
                ) {
                    showContactsSheet = true
                }

                QuickToolCard(
                    icon: Image("ic_nearby")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54),
                    title: "Near By Places",
                    accent: TrackerTheme.coral
                ) {
                    showNearbySheet = true
                }

                QuickToolCard(
                    icon: Image("ic_gpstool")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54),
                    title: "GPS Tools",
                    accent: TrackerTheme.indigo
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
    @State private var showAreaCodes = false

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
                            .background(Color.white.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }

                    Spacer()

                    VStack(spacing: 2) {
                        Text("GPS Tools")
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .foregroundStyle(TrackerTheme.ink)

                        Text("Choose a utility")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(TrackerTheme.muted)
                    }

                    Spacer()
                    Color.clear.frame(width: 42, height: 42)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 22)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 14) {
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
        }
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
        .navigationDestination(isPresented: $showAreaCodes) {
            AreaCodeScreen()
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
            } else if title == "Area Codes" {
                showAreaCodes = true
            } else {
                selectedTool = title
            }
        } label: {
            HStack(spacing: 16) {
                icon
                    .frame(width: 36, height: 36)
                    .padding(12)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Text(LocalizedStringKey(title))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(TrackerTheme.ink)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(TrackerTheme.teal)
            }
            .padding(.horizontal, 16)
            .frame(height: 78)
            .background(TrackerTheme.panel)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(TrackerTheme.stroke.opacity(0.9), lineWidth: 1)
            )
            .shadow(color: TrackerTheme.navy.opacity(0.06), radius: 14, x: 0, y: 7)
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
                    Text(LocalizedStringKey(toolName))
                        .font(.system(size: 24, weight: .bold, design: .rounded))

                    Text(LocalizedStringKey(toolDescription))
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
