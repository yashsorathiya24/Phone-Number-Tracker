import SwiftUI

struct LapRecord: Identifiable {
    let id = UUID()
    let lapNumber: Int
    let timeString: String
    let timeInterval: TimeInterval
}

struct StopwatchScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var isRunning = false
    @State private var timeElapsed: TimeInterval = 0.0
    @State private var timer: Timer? = nil
    
    @State private var laps: [LapRecord] = []
    
    // For the circular progress
    private var progress: Double {
        // progress around the circle every 60 seconds
        let seconds = timeElapsed.truncatingRemainder(dividingBy: 60)
        return seconds / 60.0
    }
    
    var body: some View {
        ZStack {
            Color(red: 248/255, green: 249/255, blue: 252/255) // Very light blue/gray background
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Top Card with Clock Face
                ZStack {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
                    
                    // Clock Face
                    ZStack {
                        // Background track
                        Circle()
                            .stroke(Color(red: 240/255, green: 244/255, blue: 255/255), lineWidth: 16)
                            .frame(width: 260, height: 260)
                        
                        // Active track (Blue)
                        Circle()
                            .trim(from: 0.0, to: progress)
                            .stroke(Color(red: 90/255, green: 115/255, blue: 245/255), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                            .frame(width: 260, height: 260)
                            .rotationEffect(.degrees(-90))
                        
                        // Ticks
                        ForEach(0..<60) { tick in
                            let isPrimary = tick % 5 == 0
                            Rectangle()
                                .fill(isPrimary ? Color.gray.opacity(0.6) : Color.gray.opacity(0.3))
                                .frame(width: isPrimary ? 2 : 1, height: isPrimary ? 12 : 8)
                                .offset(y: -110)
                                .rotationEffect(.degrees(Double(tick) * 6))
                        }
                        
                        // Time Text
                        Text(formatTime(timeElapsed))
                            .font(.system(size: 40, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 320, height: 320)
                .padding(.top, 20)
                
                // Laps Section
                VStack {
                    if laps.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "flag.fill")
                                .font(.system(size: 50))
                                .foregroundColor(Color(red: 190/255, green: 200/255, blue: 220/255))
                            
                            Text("No laps yet")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 150/255, green: 160/255, blue: 180/255))
                            
                            Text("Start the timer and tap Lap to track intervals.")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(Color(red: 160/255, green: 170/255, blue: 190/255))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .frame(maxHeight: .infinity)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 12) {
                                ForEach(laps.reversed()) { lap in
                                    HStack {
                                        Text("Lap \(lap.lapNumber)")
                                            .font(.system(size: 16, weight: .medium, design: .rounded))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text(lap.timeString)
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    
                                    Divider()
                                        .padding(.horizontal, 30)
                                }
                            }
                        }
                        .frame(maxHeight: .infinity)
                    }
                }
                
                // Controls
                HStack(spacing: 40) {
                    // Lap Button
                    VStack(spacing: 8) {
                        Button {
                            if isRunning {
                                let newLap = LapRecord(lapNumber: laps.count + 1, timeString: formatTime(timeElapsed), timeInterval: timeElapsed)
                                laps.append(newLap)
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 235/255, green: 240/255, blue: 255/255))
                                    .frame(width: 70, height: 70)
                                
                                Image(systemName: "flag.fill")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(Color(red: 90/255, green: 115/255, blue: 200/255))
                            }
                        }
                        
                        Text("Lap")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    
                    // Main Start/Stop Button
                    Button {
                        if isRunning {
                            stopTimer()
                        } else {
                            startTimer()
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(red: 90/255, green: 115/255, blue: 245/255))
                                .frame(width: 90, height: 90)
                            
                            if isRunning {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.white)
                                    .frame(width: 24, height: 24)
                            } else {
                                Image(systemName: "play.fill")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                    .offset(x: 3) // Optical alignment
                            }
                        }
                    }
                    .padding(.bottom, 22) // Align with side buttons
                    
                    // Reset Button
                    VStack(spacing: 8) {
                        Button {
                            stopTimer()
                            timeElapsed = 0.0
                            laps.removeAll()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 235/255, green: 240/255, blue: 255/255))
                                    .frame(width: 70, height: 70)
                                
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(Color(red: 90/255, green: 115/255, blue: 200/255))
                            }
                        }
                        
                        Text("Reset")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Stopwatch")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(red: 40/255, green: 100/255, blue: 230/255))
                }
            }
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        isRunning = true
        // using 0.01 for hundredths of a second
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            timeElapsed += 0.01
        }
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    private func formatTime(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        let hundredths = Int((interval.truncatingRemainder(dividingBy: 1)) * 100)
        
        return String(format: "%02d:%02d:%02d", minutes, seconds, hundredths)
    }
}
