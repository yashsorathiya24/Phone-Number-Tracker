//
//  DetailsLookupVisual.swift
//  Phone Number Tracker
//

import SwiftUI

struct DetailsLookupVisual: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 16) {
                    PhoneBadgeIcon()
                        .frame(width: 32, height: 44)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("+1 (415) 555-0132")
                            .font(.system(size: 21, weight: .heavy, design: .rounded))
                            .foregroundStyle(Color.primaryText)
                            .lineLimit(1)
                            .minimumScaleFactor(0.72)

                        Text("Number details")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(Color(red: 116 / 255, green: 121 / 255, blue: 139 / 255))
                    }
                }
                .padding(.bottom, 14)

                DetailLine(label: "Country", value: "United States")
                DetailLine(label: "Operator", value: "T-Mobile")
                DetailLine(label: "Region", value: "California, US")

                VStack(alignment: .leading, spacing: 0) {
                    Text("Line type")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(Color(red: 162 / 255, green: 166 / 255, blue: 174 / 255))
                    Text("Mobile")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color(red: 162 / 255, green: 166 / 255, blue: 174 / 255))
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
                .scaleEffect(0.88)
                .offset(x: -42, y: -45)
        }
        .padding(.horizontal, 20)
    }
}

private struct DetailLine: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 105 / 255, green: 111 / 255, blue: 130 / 255))
            Text(value)
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundStyle(Color.primaryText)
                .padding(.bottom, 4)

            Rectangle()
                .fill(Color(red: 228 / 255, green: 232 / 255, blue: 238 / 255))
                .frame(height: 1)
                .padding(.bottom, 8)
        }
    }
}
