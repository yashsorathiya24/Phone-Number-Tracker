//
//  DetailsLookupVisual.swift
//  Phone Number Tracker
//

import SwiftUI

struct DetailsLookupVisual: View {
    // Measured from the reference screenshot (dp ≈ pt)
    private let cardHeight: CGFloat = 214
    private let cornerRadius: CGFloat = 16

    var body: some View {
        card
            // Hand sits in an overlay so it never changes the layout height
            .overlay(alignment: .topTrailing) {
                AnimatedHandPointer()
                    .scaleEffect(0.84, anchor: .topTrailing)
                    .padding(.trailing, 55)
                    .offset(y: 165)
                    .allowsHitTesting(false)
            }
            .padding(.horizontal, 20)
    }

    // MARK: - Card

    private var card: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
                .padding(.bottom, 12)

            DetailLine(label: "Country", value: "United States")
            DetailLine(label: "Operator", value: "T-Mobile")
            DetailLine(label: "Region", value: "California, US")
            DetailLine(label: "Line type", value: "Mobile", isMuted: true, showsDivider: false)
        }
        .padding(.horizontal, 16)
        .padding(.top, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: cardHeight, alignment: .top)          // short, fixed-height card
        .background(Color(red: 247 / 255, green: 248 / 255, blue: 252 / 255))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(Color(red: 228 / 255, green: 232 / 255, blue: 242 / 255), lineWidth: 1)
        }
       // .mask(bottomFade)                                    // card fades out at the bottom
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
    }

    private var bottomFade: some View {
        LinearGradient(
            stops: [
                .init(color: .black, location: 0),
                .init(color: .black, location: 0.9),
                .init(color: .clear, location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    // MARK: - Header

    private var header: some View {
        HStack(alignment: .top, spacing: 18) {
            // If PhoneBadgeIcon accepts a size, pass 18 x 28 instead of scaling.
            PhoneBadgeIcon()
                .scaleEffect(0.72, anchor: .topLeading)
                .frame(width: 18, height: 28, alignment: .topLeading)
                .padding(.leading, 5)

            VStack(alignment: .leading, spacing: 0) {
                Text("+1 (415) 555-0132")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color(red: 22 / 255, green: 22 / 255, blue: 26 / 255))
                    .lineLimit(1)
                    .minimumScaleFactor(0.72)

                Text("Number details")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(red: 140 / 255, green: 144 / 255, blue: 152 / 255))
            }
        }
    }
}

// MARK: - Row

private struct DetailLine: View {
    let label: String
    let value: String
    var isMuted: Bool = false
    var showsDivider: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Label + value are packed tight (negative spacing) like the reference
            VStack(alignment: .leading, spacing: -3) {
                Text(label)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(
                        isMuted
                            ? Color(red: 168 / 255, green: 172 / 255, blue: 180 / 255)
                            : Color(red: 118 / 255, green: 122 / 255, blue: 130 / 255)
                    )

                Text(value)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(
                        isMuted
                            ? Color(red: 160 / 255, green: 164 / 255, blue: 172 / 255)
                            : Color(red: 22 / 255, green: 22 / 255, blue: 26 / 255)
                    )
            }

            if showsDivider {
                Rectangle()
                    .fill(Color(red: 224 / 255, green: 228 / 255, blue: 236 / 255))
                    .frame(height: 1)
                    .padding(.top, 1)
                    .padding(.bottom, 8)
            }
        }
    }
}
