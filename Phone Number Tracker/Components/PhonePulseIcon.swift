//
//  PhonePulseIcon.swift
//  Phone Number Tracker
//

import SwiftUI

struct PhonePulseIcon: View {
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.callGreen.opacity(0.24))
                .scaleEffect(pulse ? 1.18 : 0.92)
                .opacity(pulse ? 0 : 0.8)

            Circle()
                .fill(Color.callGreen)

            Image(systemName: "phone.fill")
                .font(.system(size: 62, weight: .bold))
                .foregroundStyle(.white)
                .rotationEffect(.degrees(-18))
        }
        .task {
            withAnimation(.easeOut(duration: 1.05).repeatForever(autoreverses: false)) {
                pulse = true
            }
        }
    }
}
