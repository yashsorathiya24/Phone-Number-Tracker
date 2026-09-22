import SwiftUI
import CoreLocation

struct SpeedometerScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var locationManager = LocationManager()
    
    @State private var isRunning = false
    @State private var topSpeed: Double = 0.0
    
    // km/h conversion
    private var currentSpeedKmh: Double {
        let speed = locationManager.speed
        return speed > 0 ? (speed * 3.6) : 0.0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Speedometer Gauge
            ZStack {
                // Background Arc
                Path { path in
                    path.addArc(
                        center: CGPoint(x: 160, y: 160),
                        radius: 140,
                        startAngle: .degrees(150),
                        endAngle: .degrees(390),
                        clockwise: false
                    )
                }
                .stroke(Color(red: 220/255, green: 225/255, blue: 230/255), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                
                // Active Arc (Blue) up to current speed
                Path { path in
                    path.addArc(
                        center: CGPoint(x: 160, y: 160),
                        radius: 140,
                        startAngle: .degrees(150),
                        endAngle: .degrees(angleForSpeed(isRunning ? currentSpeedKmh : 0.0)),
                        clockwise: false
                    )
                }
                .stroke(Color(red: 45/255, green: 120/255, blue: 240/255), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                
                // Ticks and Labels
                ForEach(0...9, id: \.self) { i in
                    let value = Double(i) * 20.0
                    let angle = angleForSpeed(value)
                    let center = CGPoint(x: 160, y: 160)
                    
                    // Tick mark
                    Path { path in
                        let startRadius: CGFloat = 132
                        let endRadius: CGFloat = 148
                        
                        let startX = center.x + startRadius * cos(CGFloat(angle) * .pi / 180)
                        let startY = center.y + startRadius * sin(CGFloat(angle) * .pi / 180)
                        
                        let endX = center.x + endRadius * cos(CGFloat(angle) * .pi / 180)
                        let endY = center.y + endRadius * sin(CGFloat(angle) * .pi / 180)
                        
                        path.move(to: CGPoint(x: startX, y: startY))
                        path.addLine(to: CGPoint(x: endX, y: endY))
                    }
                    .stroke(Color.black, lineWidth: 2)
                    
                    // Label
                    let labelRadius: CGFloat = 105
                    let labelX = center.x + labelRadius * cos(CGFloat(angle) * .pi / 180)
                    let labelY = center.y + labelRadius * sin(CGFloat(angle) * .pi / 180)
                    
                    Text("\(Int(value))")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .position(x: labelX, y: labelY)
                }
                
                // Needle
                let needleAngle = angleForSpeed(isRunning ? currentSpeedKmh : 0.0)
                ZStack {
                    Path { path in
                        path.move(to: CGPoint(x: 160, y: 160))
                        
                        let needleRadius: CGFloat = 140
                        let endX = 160 + needleRadius * cos(CGFloat(needleAngle) * .pi / 180)
                        let endY = 160 + needleRadius * sin(CGFloat(needleAngle) * .pi / 180)
                        
                        path.addLine(to: CGPoint(x: endX, y: endY))
                    }
                    .stroke(Color(red: 45/255, green: 120/255, blue: 240/255), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    
                    Circle()
                        .stroke(Color.black, lineWidth: 4)
                        .background(Circle().fill(Color.white))
                        .frame(width: 16, height: 16)
                }
            }
            .frame(width: 320, height: 260) // Not full 320 height because arc is only top part
            .padding(.top, 40)
            
            // Speed Text
            Text(String(format: "%.1f", isRunning ? currentSpeedKmh : 0.0))
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding(.top, 20)
            
            Text("km/h")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(red: 45/255, green: 120/255, blue: 240/255))
                .padding(.bottom, 20)
            
            Text(locationManager.location == nil ? "Waiting for GPS signal..." : "GPS Active")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.black)
            
            Text(String(format: "Top speed: %.1f km/h", topSpeed))
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.black)
                .padding(.top, 8)
            
            Spacer()
            
            Button {
                isRunning.toggle()
                if isRunning {
                    locationManager.startUpdating()
                } else {
                    locationManager.stopUpdating()
                }
            } label: {
                Text(isRunning ? "Stop" : "Start")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color(red: 45/255, green: 150/255, blue: 255/255))
                    .cornerRadius(30)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
        .navigationTitle("Speedometer")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }
            }
        }
        .onChange(of: currentSpeedKmh) { newSpeed in
            if isRunning && newSpeed > topSpeed {
                topSpeed = newSpeed
            }
        }
        .onAppear {
            if locationManager.authorizationStatus == .notDetermined {
                locationManager.requestPermission()
            }
            // we let the user tap "Start" to begin.
            // Or maybe start automatically if authorized?
            // The screenshot shows a "Stop" button, implying it was running. Let's make it start automatically.
            isRunning = true
            locationManager.startUpdating()
        }
        .onDisappear {
            locationManager.stopUpdating()
        }
    }
    
    // Calculates angle in degrees for a given speed
    // Arc goes from 150 degrees to 390 degrees. That's a 240 degree span.
    // 0 km/h is 150 degrees. 180 km/h is 390 degrees.
    private func angleForSpeed(_ speed: Double) -> Double {
        let clampedSpeed = min(max(speed, 0), 180)
        return 150.0 + (clampedSpeed / 180.0) * 240.0
    }
}
