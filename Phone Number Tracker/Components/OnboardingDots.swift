//
//  OnboardingDots.swift
//  Phone Number Tracker
//

import SwiftUI

struct OnboardingDots: View {
    let currentPage: Int
    let pageCount: Int

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<pageCount, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.trackerBlue : Color(red: 210 / 255, green: 214 / 255, blue: 220 / 255))
                    .frame(width: index == currentPage ? 26 : 6, height: 5)
            }
        }
    }
}
