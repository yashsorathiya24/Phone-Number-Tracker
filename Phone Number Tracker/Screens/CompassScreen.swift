import SwiftUI
import CoreLocation

struct CompassScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            Color(red: 242/255, green: 246/255, blue: 255/255) // light background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Main Compass Card
                VStack(spacing: 0) {
                    HStack {
                        Text("COMPASS")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(red: 130/255, green: 135/255, blue: 145/255))
                        Spacer()
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                    
                    Text("\(Int(currentHeading))° \(directionString(for: currentHeading))")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 45/255, green: 120/255, blue: 240/255))
                        .padding(.top, 10)
                        .padding(.bottom, 40)
                    
                    // Compass Dial
                    ZStack {
                        // Background
                        Circle()
                            .fill(Color(red: 28/255, green: 34/255, blue: 46/255))
                            .frame(width: 280, height: 280)
                            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                        
                        // Ticks and Labels
                        ForEach(0..<72) { tick in
                            let angle = Double(tick) * 5.0
                            let isPrimary = tick % 18 == 0
                            let isSecondary = tick % 9 == 0 && !isPrimary
                            
                            Rectangle()
                                .fill(tickColor(for: tick))
                                .frame(width: isPrimary ? 3 : (isSecondary ? 2 : 1),
                                       height: isPrimary ? 15 : (isSecondary ? 10 : 6))
                                .offset(y: -130)
                                .rotationEffect(.degrees(angle))
                        }
                        
                        // Direction Labels
                        let labels = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
                        ForEach(0..<8) { i in
                            let angle = Double(i) * 45.0
                            Text(labels[i])
                                .font(.system(size: i % 2 == 0 ? 24 : 16, weight: .bold, design: .rounded))
                                .foregroundColor(i == 0 ? .red : (i % 2 == 0 ? .white : .gray))
                                .rotationEffect(.degrees(-angle)) // Keep text upright relative to its position on the dial
                                .offset(y: -95)
                                .rotationEffect(.degrees(angle))
                        }
                    }
                    .rotationEffect(.degrees(-currentHeading)) // Rotate dial based on heading
                    .overlay(
                        // Fixed Needle pointing UP
                        ZStack {
                            // Top half (Red)
                            Path { path in
                                path.move(to: CGPoint(x: 140, y: 30))
                                path.addLine(to: CGPoint(x: 150, y: 140))
                                path.addLine(to: CGPoint(x: 130, y: 140))
                                path.closeSubpath()
                            }
                            .fill(Color.red)
                            
                            // Bottom half (Gray)
                            Path { path in
                                path.move(to: CGPoint(x: 140, y: 250))
                                path.addLine(to: CGPoint(x: 150, y: 140))
                                path.addLine(to: CGPoint(x: 130, y: 140))
                                path.closeSubpath()
                            }
                            .fill(Color.gray)
                            
                            // Center circle
                            Circle()
                                .fill(Color.red)
                                .frame(width: 14, height: 14)
                            
                            Circle()
                                .stroke(Color(red: 28/255, green: 34/255, blue: 46/255), lineWidth: 4)
                                .frame(width: 14, height: 14)
                        }
                        .frame(width: 280, height: 280)
                    )
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 500)
                .background(Color.white)
                .cornerRadius(24)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 16)
                
                // Location Card
                VStack(alignment: .leading, spacing: 8) {
                    Text("MY LOCATION")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(red: 130/255, green: 135/255, blue: 145/255))
                    
                    Text(locationManager.addressString)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    if let location = locationManager.location {
                        Text(String(format: "Latitude: %.5f, Longitude: %.5f", location.coordinate.latitude, location.coordinate.longitude))
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color(red: 45/255, green: 120/255, blue: 240/255))
                    } else {
                        Text("Fetching coordinates...")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color(red: 45/255, green: 120/255, blue: 240/255))
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .navigationTitle("Compass")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(red: 45/255, green: 120/255, blue: 240/255))
                }
            }
        }
        .onAppear {
            if locationManager.authorizationStatus == .notDetermined {
                locationManager.requestPermission()
            } else {
                locationManager.startUpdating()
            }
        }
        .onDisappear {
            locationManager.stopUpdating()
        }
    }
    
    private var currentHeading: Double {
        let heading = locationManager.heading?.trueHeading ?? locationManager.heading?.magneticHeading ?? 0.0
        return heading >= 0 ? heading : 0.0
    }
    
    private func directionString(for degrees: Double) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((degrees + 22.5) / 45.0) & 7
        return directions[index]
    }
    
    private func tickColor(for tick: Int) -> Color {
        if tick == 0 {
            return .red
        } else if tick % 18 == 0 {
            return .red
        }
        return Color.gray.opacity(0.5)
    }
}
