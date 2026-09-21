//
//  PhoneBadgeIcon.swift
//  Phone Number Tracker
//

import SwiftUI

struct PhoneBadgeIcon: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(Color.trackerBlue)
                .frame(width: 24, height: 42)
            
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .fill(Color.white)
                .frame(width: 16, height: 26)
                .offset(y: -2)
            
            Circle()
                .fill(Color.white)
                .frame(width: 3.5, height: 3.5)
                .offset(y: 15)
        }
    }
}
