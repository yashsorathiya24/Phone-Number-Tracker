//
//  WorldwideSearchVisual.swift
//  Phone Number Tracker
//

import SwiftUI

struct WorldwideSearchVisual: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 19) {
                HStack(spacing: 12) {
                    Image(systemName: "arrow.right.circle")
                        .font(.system(size: 24, weight: .light))
                        .foregroundStyle(Color.trackerBlue)

                    VStack(alignment: .leading, spacing: 3) {
                        Text("+44 7911 123456")
                            .font(.system(size: 16, weight: .heavy, design: .rounded))
                            .foregroundStyle(Color.primaryText)
                        Text("Search worldwide numbers")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(Color(red: 101 / 255, green: 105 / 255, blue: 123 / 255))
                    }

                    Spacer()

                    Text("Search")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 14)
                        .frame(height: 32)
                        .background(Color.trackerBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                }
                .padding(.horizontal, 16)
                .frame(height: 52)
                .background(Color(red: 247 / 255, green: 249 / 255, blue: 253 / 255))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 5)

                SearchResultRow(number: "1", country: "United Kingdom", detail: "Vodafone  •  London")
                SearchResultRow(number: "2", country: "Germany", detail: "Telekom  •  Berlin")
                SearchResultRow(number: "3", country: "India", detail: "Airtel  •  Mumbai")
            }
            .padding(.horizontal, 24)

            AnimatedHandPointer()
                .offset(x: -20, y: 10)
        }
    }
}

private struct SearchResultRow: View {
    let number: String
    let country: String
    let detail: String

    var body: some View {
        HStack(spacing: 18) {
            Text(number)
                .font(.system(size: 17, weight: .heavy, design: .rounded))
                .foregroundStyle(Color.trackerBlue)
                .frame(width: 28, height: 28)
                .background(Color.trackerBlue.opacity(0.08))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(country)
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color.primaryText)
                Text(detail)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 69 / 255, green: 73 / 255, blue: 89 / 255))
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(height: 72)
        .background(Color(red: 247 / 255, green: 249 / 255, blue: 253 / 255))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 5)
    }
}
