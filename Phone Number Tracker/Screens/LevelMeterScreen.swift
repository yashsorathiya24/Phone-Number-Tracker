import SwiftUI
import CoreMotion
import Combine

enum LevelMode {
    case square
    case circle
}

class LevelMotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var pitch: Double = 0.0 // Y axis
    @Published var roll: Double = 0.0  // X axis
    
    func startUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let data = data else { return }
                self?.pitch = data.attitude.pitch * 180 / .pi
                self?.roll = data.attitude.roll * 180 / .pi
            }
        }
    }
    
    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}

struct LevelMeterScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var motionManager = LevelMotionManager()
    
    @State private var mode: LevelMode = .square
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Level Meter")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        mode = (mode == .square) ? .circle : .square
                    } label: {
                        if mode == .square {
                            Circle()
                                .stroke(Color.black, lineWidth: 3)
                                .frame(width: 20, height: 20)
                        } else {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.black, lineWidth: 3)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                Spacer()
                
                ZStack {
                    // Y axis text
                    Text(String(format: "Y: %.1f°", abs(motionManager.pitch)))
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .rotationEffect(.degrees(90))
                        .offset(x: -140)
                    
                    // Main Level Graphic
                    ZStack {
                        if mode == .square {
                            // Outer
                            RoundedRectangle(cornerRadius: 40, style: .continuous)
                                .stroke(Color(red: 20/255, green: 160/255, blue: 200/255), lineWidth: 30)
                                .frame(width: 200, height: 200)
                            
                            // Target center (Red)
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color(red: 200/255, green: 70/255, blue: 70/255), lineWidth: 4)
                                .frame(width: 45, height: 45)
                            
                            // Moving bubble (Green)
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color(red: 60/255, green: 180/255, blue: 130/255), lineWidth: 4)
                                .frame(width: 30, height: 30)
                                .offset(x: bubbleOffsetX, y: bubbleOffsetY)
                            
                        } else {
                            // Outer
                            Circle()
                                .stroke(Color(red: 70/255, green: 130/255, blue: 245/255), lineWidth: 30)
                                .frame(width: 200, height: 200)
                            
                            // Target center (Red)
                            Circle()
                                .stroke(Color(red: 200/255, green: 70/255, blue: 70/255), lineWidth: 4)
                                .frame(width: 45, height: 45)
                            
                            // Moving bubble (Green)
                            Circle()
                                .stroke(Color(red: 60/255, green: 180/255, blue: 130/255), lineWidth: 4)
                                .frame(width: 30, height: 30)
                                .offset(x: bubbleOffsetX, y: bubbleOffsetY)
                        }
                    }
                    
                    // X axis text
                    Text(String(format: "X: %.1f°", abs(motionManager.roll)))
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .offset(y: 200)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Level Meter")
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
        .onAppear {
            motionManager.startUpdates()
        }
        .onDisappear {
            motionManager.stopUpdates()
        }
    }
    
    private var bubbleOffsetX: CGFloat {
        // Roll is around X axis. Positive roll tilts right.
        // We want the bubble to move according to tilt.
        let maxOffset: CGFloat = 85.0 // Inside the 200px shape
        let rollVal = max(-45.0, min(45.0, motionManager.roll))
        return CGFloat(rollVal / 45.0) * maxOffset
    }
    
    private var bubbleOffsetY: CGFloat {
        // Pitch is around Y axis. Positive pitch tilts up (top of device towards user).
        let maxOffset: CGFloat = 85.0
        let pitchVal = max(-45.0, min(45.0, motionManager.pitch))
        return CGFloat(pitchVal / 45.0) * maxOffset
    }
}
