//
//  PhoneBadgeIcon.swift
//  Phone Number Tracker
//

import SwiftUI

struct PhoneBadgeIcon: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(Color.trackerBlue, lineWidth: 2.3)
            .frame(width: 23, height: 36)
            .overlay(alignment: .bottom) {
                Capsule()
                    .fill(Color.trackerBlue)
                    .frame(width: 7, height: 2.2)
                    .padding(.bottom, 4)
            }
    }
}
