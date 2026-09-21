//
//  LiveLocationVisual.swift
//  Phone Number Tracker
//

import SwiftUI

struct LiveLocationVisual: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 14) {
                MapPanel()
                    .frame(height: 155)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Live caller location")
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color.primaryText)

                    Text("San Francisco, CA  •  +1  •  4G LTE")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 69 / 255, green: 73 / 255, blue: 89 / 255))
                }

                HStack(spacing: 8) {
                    LocationChip(text: "Country +1")
                    LocationChip(text: "Network LTE")
                    LocationChip(text: "Active now")
                }
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 247 / 255, green: 249 / 255, blue: 253 / 255))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color(red: 224 / 255, green: 228 / 255, blue: 237 / 255), lineWidth: 1.5)
            }
            .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 8)

            AnimatedHandPointer()
                .scaleEffect(0.9)
                .offset(x: -25, y: 44)
        }
        .padding(.horizontal, 24)
    }
}

private struct MapPanel: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(red: 227 / 255, green: 236 / 255, blue: 252 / 255))

            GridLines()
                .stroke(.white, lineWidth: 2)
                .opacity(0.95)

            Ellipse()
                .fill(Color(red: 190 / 255, green: 214 / 255, blue: 248 / 255).opacity(0.75))
                .frame(width: 210, height: 135)
                .offset(x: 80, y: -8)

            ForEach(0..<4, id: \.self) { index in
                Circle()
                    .stroke(Color(red: 130 / 255, green: 169 / 255, blue: 224 / 255).opacity(0.2), lineWidth: 2.5)
                    .frame(width: CGFloat(56 + index * 44), height: CGFloat(56 + index * 44))
                    .offset(x: -6, y: -6)
            }

            ZStack {
                Circle()
                    .fill(Color(red: 255 / 255, green: 63 / 255, blue: 77 / 255))
                    .frame(width: 26, height: 26)
                Circle()
                    .fill(.white)
                    .frame(width: 8, height: 8)
            }
            .offset(x: -6, y: -6)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

private struct GridLines: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for index in 1..<7 {
            let x = rect.width * CGFloat(index) / 7
            path.move(to: CGPoint(x: x, y: 12))
            path.addLine(to: CGPoint(x: x, y: rect.height - 12))
        }
        for index in 1..<6 {
            let y = rect.height * CGFloat(index) / 6
            path.move(to: CGPoint(x: 10, y: y))
            path.addLine(to: CGPoint(x: rect.width - 10, y: y))
        }
        return path
    }
}

private struct LocationChip: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .medium, design: .rounded))
            .foregroundStyle(Color.trackerBlue)
            .padding(.horizontal, 11)
            .frame(height: 28)
            .background(Color.trackerBlue.opacity(0.08))
            .clipShape(Capsule())
            .lineLimit(1)
    }
}
