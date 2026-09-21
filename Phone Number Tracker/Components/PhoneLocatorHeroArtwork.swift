//
//  PhoneLocatorHeroArtwork.swift
//  Phone Number Tracker
//

import SwiftUI

struct PhoneLocatorHeroArtwork: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Hand holding phone container
            ZStack {
                // Phone outer body
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(red: 45 / 255, green: 49 / 255, blue: 55 / 255))
                    .frame(width: 96, height: 138)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1.5)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 10, x: -3, y: 6)

                // Phone screen
                ZStack {
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .fill(Color.white)

                    // Map elements
                    MapIllustration()
                        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))

                    // 3D Red location pin
                    PinMarker()
                        .offset(x: 18, y: -26)
                }
                .frame(width: 82, height: 124)

                // Hand and fingers gripping phone
                HandIllustration()
                    .offset(x: -32, y: 30)
            }
        }
        .frame(width: 140, height: 150)
    }
}

private struct MapIllustration: View {
    var body: some View {
        ZStack {
            // Base background
            Color(red: 242 / 255, green: 247 / 255, blue: 245 / 255)

            // Green map terrain shapes
            Path { path in
                path.move(to: CGPoint(x: 0, y: 15))
                path.addQuadCurve(to: CGPoint(x: 45, y: 0), control: CGPoint(x: 15, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.closeSubpath()

                path.move(to: CGPoint(x: 35, y: 0))
                path.addCurve(to: CGPoint(x: 82, y: 60), control1: CGPoint(x: 65, y: 15), control2: CGPoint(x: 55, y: 45))
                path.addLine(to: CGPoint(x: 82, y: 0))
                path.closeSubpath()

                path.move(to: CGPoint(x: 0, y: 65))
                path.addCurve(to: CGPoint(x: 50, y: 124), control1: CGPoint(x: 20, y: 80), control2: CGPoint(x: 35, y: 105))
                path.addLine(to: CGPoint(x: 0, y: 124))
                path.closeSubpath()
            }
            .fill(Color(red: 172 / 255, green: 230 / 255, blue: 180 / 255))

            // Blue river / water path
            Path { path in
                path.move(to: CGPoint(x: 0, y: 85))
                path.addCurve(to: CGPoint(x: 82, y: 80), control1: CGPoint(x: 30, y: 65), control2: CGPoint(x: 50, y: 105))
                path.addLine(to: CGPoint(x: 82, y: 98))
                path.addCurve(to: CGPoint(x: 0, y: 102), control1: CGPoint(x: 50, y: 122), control2: CGPoint(x: 30, y: 82))
                path.closeSubpath()
            }
            .fill(Color(red: 135 / 255, green: 195 / 255, blue: 250 / 255))

            // Road route line (white with gray outline)
            Path { path in
                path.move(to: CGPoint(x: 12, y: 110))
                path.addCurve(to: CGPoint(x: 58, y: 38), control1: CGPoint(x: 25, y: 60), control2: CGPoint(x: 40, y: 55))
            }
            .stroke(Color.white, style: StrokeStyle(lineWidth: 4, lineCap: .round))

            // Red navigation track line
            Path { path in
                path.move(to: CGPoint(x: 15, y: 100))
                path.addCurve(to: CGPoint(x: 55, y: 44), control1: CGPoint(x: 25, y: 65), control2: CGPoint(x: 38, y: 58))
            }
            .stroke(Color(red: 215 / 255, green: 55 / 255, blue: 60 / 255), style: StrokeStyle(lineWidth: 2.2, lineCap: .round))
        }
    }
}

private struct PinMarker: View {
    var body: some View {
        ZStack {
            // Drop shadow
            Ellipse()
                .fill(Color.black.opacity(0.28))
                .frame(width: 14, height: 6)
                .offset(y: 19)

            // Red Map Pin
            Image(systemName: "mappin")
                .font(.system(size: 38, weight: .bold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 255 / 255, green: 80 / 255, blue: 85 / 255),
                            Color(red: 200 / 255, green: 30 / 255, blue: 40 / 255)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: Color.red.opacity(0.35), radius: 4, x: 0, y: 3)
        }
    }
}

private struct HandIllustration: View {
    var body: some View {
        ZStack {
            // Blue shirt sleeve / cuff
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 60 / 255, green: 170 / 255, blue: 250 / 255),
                            Color(red: 35 / 255, green: 130 / 255, blue: 240 / 255)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 32, height: 14)
                .offset(x: -8, y: 28)

            // Palm & Hand base
            Path { path in
                path.move(to: CGPoint(x: 8, y: 35))
                path.addQuadCurve(to: CGPoint(x: 32, y: 15), control: CGPoint(x: 10, y: 18))
                path.addCurve(to: CGPoint(x: 38, y: -10), control1: CGPoint(x: 35, y: 5), control2: CGPoint(x: 38, y: -2))
                path.addQuadCurve(to: CGPoint(x: 28, y: -12), control: CGPoint(x: 34, y: -14))
                path.addCurve(to: CGPoint(x: 20, y: 15), control1: CGPoint(x: 25, y: -2), control2: CGPoint(x: 22, y: 8))
                path.addQuadCurve(to: CGPoint(x: 8, y: 35), control: CGPoint(x: 12, y: 25))
                path.closeSubpath()
            }
            .fill(Color(red: 252 / 255, green: 202 / 255, blue: 176 / 255))

            // Fingers wrapping over phone
            VStack(spacing: 4) {
                ForEach(0..<3) { _ in
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 254 / 255, green: 215 / 255, blue: 195 / 255),
                                    Color(red: 244 / 255, green: 185 / 255, blue: 158 / 255)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 22, height: 7)
                        .offset(x: 16)
                }
            }
            .offset(y: 4)
        }
    }
}
