//
//  NumberPatternBackground.swift
//  Phone Number Tracker
//

import SwiftUI

struct NumberPatternBackground: View {
    private let rows = [
        "6  1  8  2  3  +  3  8  6  2  0  1  5  9  7  7  +  0  5  5  1",
        "4  8  4  6  2  0  6  +  3  7  4  9  0  7  0  1  9  6  5  2",
        "5  1  2  8  4  6  7  7  8  2  3  4  6  5  1  9  0  8  6",
        "2  4  7  9  6  0  5  3  7  9  0  +  7  2  0  4  6  1  8"
    ]

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 7) {
                ForEach(0..<50, id: \.self) { index in
                    Text(rows[index % rows.count])
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color(red: 200 / 255, green: 210 / 255, blue: 228 / 255).opacity(0.75))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .mask(
                LinearGradient(
                    stops: [
                        .init(color: .black, location: 0),
                        .init(color: .black.opacity(0.95), location: 0.25),
                        .init(color: .black.opacity(0.7), location: 0.55),
                        .init(color: .black.opacity(0.25), location: 0.80),
                        .init(color: .clear, location: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()
        }
    }
}
