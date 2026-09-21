//
//  HistoryLookupVisual.swift
//  Phone Number Tracker
//

import SwiftUI

struct HistoryLookupVisual: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Recent lookups")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color.primaryText)
                Text("Saved in one place")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 103 / 255, green: 108 / 255, blue: 127 / 255))
            }
            .padding(.leading, 2)

            HistoryRow(number: "+1 (415) 555-0132", detail: "California  •  T-Mobile", day: "Today")
            HistoryRow(number: "+44 7911 123456", detail: "London  •  Vodafone", day: "Yesterday")
            HistoryRow(number: "+49 1512 3456789", detail: "Berlin  •  Telekom", day: "Mon")
        }
        .padding(.horizontal, 24)
    }
}

private struct HistoryRow: View {
    let number: String
    let detail: String
    let day: String

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.trackerBlue)
                VStack(spacing: 2) {
                    Circle().fill(.white).frame(width: 7, height: 7)
                    Capsule().fill(.white).frame(width: 12, height: 5)
                }
            }
            .frame(width: 26, height: 34)

            VStack(alignment: .leading, spacing: 4) {
                Text(number)
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color.primaryText)
                Text(detail)
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(Color(red: 70 / 255, green: 75 / 255, blue: 91 / 255))
            }

            Spacer()

            Text(day)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 108 / 255, green: 113 / 255, blue: 132 / 255))
                .padding(.bottom, 22)
        }
        .padding(.horizontal, 20)
        .frame(height: 64)
        .background(Color(red: 247 / 255, green: 249 / 255, blue: 253 / 255))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 5)
    }
}
