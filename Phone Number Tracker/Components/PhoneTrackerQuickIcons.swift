//
//  PhoneTrackerQuickIcons.swift
//  Phone Number Tracker
//

import SwiftUI

// MARK: - 3D Contacts Book Icon
struct Contacts3DIcon: View {
    var body: some View {
        ZStack {
            // Main notebook body
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 65 / 255, green: 145 / 255, blue: 250 / 255),
                            Color(red: 35 / 255, green: 105 / 255, blue: 225 / 255)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 48, height: 50)
                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 4)

            // Colorful page tabs on right edge
            VStack(spacing: 5) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 255 / 255, green: 190 / 255, blue: 45 / 255))
                    .frame(width: 6, height: 8)
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 245 / 255, green: 65 / 255, blue: 75 / 255))
                    .frame(width: 6, height: 8)
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(red: 50 / 255, green: 205 / 255, blue: 110 / 255))
                    .frame(width: 6, height: 8)
            }
            .offset(x: 23)

            // Spiral wire rings on left
            VStack(spacing: 4) {
                ForEach(0..<5) { _ in
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 50 / 255, green: 55 / 255, blue: 65 / 255),
                                    Color(red: 90 / 255, green: 100 / 255, blue: 115 / 255)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 10, height: 5)
                }
            }
            .offset(x: -22)

            // White phone receiver badge in center
            Image(systemName: "phone.fill")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.18), radius: 2, x: 0, y: 1.5)
                .offset(x: 2)
        }
        .frame(width: 58, height: 56)
    }
}

// MARK: - 3D Nearby Places Icon
struct NearbyPlaces3DIcon: View {
    var body: some View {
        ZStack {
            // Map ground base
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 215 / 255, green: 235 / 255, blue: 250 / 255),
                            Color(red: 185 / 255, green: 215 / 255, blue: 245 / 255)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
                .shadow(color: Color.gray.opacity(0.25), radius: 5, x: 0, y: 4)

            // Green map patch
            Path { path in
                path.move(to: CGPoint(x: 0, y: 10))
                path.addQuadCurve(to: CGPoint(x: 28, y: 0), control: CGPoint(x: 10, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 0))
                path.closeSubpath()

                path.move(to: CGPoint(x: 0, y: 30))
                path.addQuadCurve(to: CGPoint(x: 35, y: 50), control: CGPoint(x: 15, y: 45))
                path.addLine(to: CGPoint(x: 0, y: 50))
                path.closeSubpath()
            }
            .fill(Color(red: 145 / 255, green: 215 / 255, blue: 140 / 255))
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            // Road path
            Path { path in
                path.move(to: CGPoint(x: 10, y: 45))
                path.addCurve(to: CGPoint(x: 40, y: 15), control1: CGPoint(x: 18, y: 20), control2: CGPoint(x: 32, y: 35))
            }
            .stroke(Color.white, style: StrokeStyle(lineWidth: 3.5, lineCap: .round))
            .frame(width: 50, height: 50)

            // Small red pins on map
            ZStack {
                Circle()
                    .fill(Color(red: 235 / 255, green: 60 / 255, blue: 60 / 255))
                    .frame(width: 10, height: 10)
                    .offset(x: -12, y: 8)

                Circle()
                    .fill(Color(red: 235 / 255, green: 60 / 255, blue: 60 / 255))
                    .frame(width: 11, height: 11)
                    .offset(x: 8, y: 12)
            }

            // Central beacon / pin with waves
            VStack(spacing: 0) {
                // Radio wave arcs
                Image(systemName: "dot.radiowaves.left.and.right")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color(red: 250 / 255, green: 180 / 255, blue: 40 / 255))
                    .offset(y: 2)

                // Blue/Red pin
                Circle()
                    .fill(Color(red: 70 / 255, green: 150 / 255, blue: 250 / 255))
                    .frame(width: 12, height: 12)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 1.5)
                    )

                Rectangle()
                    .fill(Color(red: 120 / 255, green: 130 / 255, blue: 145 / 255))
                    .frame(width: 2, height: 8)
            }
            .offset(x: 3, y: -10)
        }
        .frame(width: 58, height: 56)
    }
}

// MARK: - 3D GPS Tools Icon
struct GPSTools3DIcon: View {
    var body: some View {
        ZStack {
            // Cyan/Blue map tile
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 90 / 255, green: 195 / 255, blue: 250 / 255),
                            Color(red: 45 / 255, green: 140 / 255, blue: 245 / 255)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
                .shadow(color: Color.cyan.opacity(0.35), radius: 5, x: 0, y: 4)

            // Street grid lines on tile
            Path { path in
                // Horizontal lines
                path.move(to: CGPoint(x: 5, y: 18))
                path.addLine(to: CGPoint(x: 45, y: 18))
                path.move(to: CGPoint(x: 5, y: 34))
                path.addLine(to: CGPoint(x: 45, y: 34))

                // Vertical lines
                path.move(to: CGPoint(x: 18, y: 5))
                path.addLine(to: CGPoint(x: 18, y: 45))
                path.move(to: CGPoint(x: 34, y: 5))
                path.addLine(to: CGPoint(x: 34, y: 45))
            }
            .stroke(Color.white.opacity(0.55), lineWidth: 2)
            .frame(width: 50, height: 50)

            // 3D Red Navigation Arrow pointer (facing top-right)
            ZStack {
                // Arrow shadow
                Path { path in
                    path.move(to: CGPoint(x: 20, y: 6))
                    path.addLine(to: CGPoint(x: 34, y: 32))
                    path.addLine(to: CGPoint(x: 20, y: 26))
                    path.addLine(to: CGPoint(x: 6, y: 32))
                    path.closeSubpath()
                }
                .fill(Color.black.opacity(0.2))
                .offset(x: 2, y: 3)

                // Left wing of arrow (darker red shading for 3D effect)
                Path { path in
                    path.move(to: CGPoint(x: 20, y: 6))
                    path.addLine(to: CGPoint(x: 6, y: 32))
                    path.addLine(to: CGPoint(x: 20, y: 26))
                    path.closeSubpath()
                }
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 235 / 255, green: 50 / 255, blue: 55 / 255),
                            Color(red: 185 / 255, green: 25 / 255, blue: 35 / 255)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                // Right wing of arrow (lighter red highlight for 3D effect)
                Path { path in
                    path.move(to: CGPoint(x: 20, y: 6))
                    path.addLine(to: CGPoint(x: 34, y: 32))
                    path.addLine(to: CGPoint(x: 20, y: 26))
                    path.closeSubpath()
                }
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 255 / 255, green: 90 / 255, blue: 95 / 255),
                            Color(red: 225 / 255, green: 40 / 255, blue: 50 / 255)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .frame(width: 40, height: 40)
        }
        .frame(width: 58, height: 56)
    }
}

// MARK: - Reusable Quick Tool Card
struct QuickToolCard<IconView: View>: View {
    let icon: IconView
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                icon
                    .padding(.top, 6)

                VStack(spacing: 6) {
                    Text(title)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 22 / 255, green: 24 / 255, blue: 28 / 255))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(subtitle)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(Color(red: 120 / 255, green: 124 / 255, blue: 135 / 255))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .frame(height: 172)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color(red: 226 / 255, green: 232 / 255, blue: 240 / 255), lineWidth: 1.2)
            )
            .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }
}
