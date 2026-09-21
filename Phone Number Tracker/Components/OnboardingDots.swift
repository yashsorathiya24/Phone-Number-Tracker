//
//  OnboardingDots.swift
//  Phone Number Tracker
//

import SwiftUI

struct OnboardingDots: View {
    let currentPage: Int
    let pageCount: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<pageCount, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.trackerBlue : Color(red: 225 / 255, green: 229 / 255, blue: 234 / 255))
                    .frame(width: index == currentPage ? 29 : 6, height: 5)
            }
        }
    }
}
