//
//  DetailsLookupVisual.swift
//  Phone Number Tracker
//

import SwiftUI

struct DetailsLookupVisual: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                header
                    .padding(.bottom, 14)

                DetailLine(label: "Country", value: "United States")
                DetailLine(label: "Operator", value: "T-Mobile")
                DetailLine(label: "Region", value: "California, US")
                DetailLine(label: "Line type", value: "Mobile", isMuted: true, showsDivider: false)
            }
            .padding(.horizontal, 18)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 247 / 255, green: 248 / 255, blue: 251 / 255))
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.12), radius: 16, x: 0, y: 10)

            AnimatedHandPointer()
                .scaleEffect(0.92)
                .padding(.top, 158)
                .padding(.trailing, 10)
                .allowsHitTesting(false)
        }
        .padding(.horizontal, 16)
    }

    private var header: some View {
        HStack(alignment: .top, spacing: 14) {
            PhoneBadgeIcon()
                .padding(.top, 1)

            VStack(alignment: .leading, spacing: 6) {
                Text("+1 (415) 555-0132")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color(red: 22 / 255, green: 22 / 255, blue: 26 / 255))
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)

                Text("Number details")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color(red: 148 / 255, green: 152 / 255, blue: 162 / 255))
            }
        }
    }
}

private struct DetailLine: View {
    let label: String
    let value: String
    var isMuted: Bool = false
    var showsDivider: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color(red: 158 / 255, green: 162 / 255, blue: 170 / 255))

            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(
                    isMuted
                        ? Color(red: 168 / 255, green: 172 / 255, blue: 180 / 255)
                        : Color(red: 22 / 255, green: 22 / 255, blue: 26 / 255)
                )
                .padding(.top, 1)
                .padding(.bottom, showsDivider ? 10 : 0)

            if showsDivider {
                Rectangle()
                    .fill(Color(red: 230 / 255, green: 232 / 255, blue: 237 / 255))
                    .frame(height: 1)
                    .padding(.bottom, 10)
            }
        }
    }
}
