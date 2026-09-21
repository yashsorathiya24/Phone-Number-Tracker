//
//  AnimatedHandPointer.swift
//  Phone Number Tracker
//

import SwiftUI

struct AnimatedHandPointer: View {
    @State private var isTapping = false

    var body: some View {
        Image(systemName: "hand.point.up.left.fill")
            .font(.system(size: 58, weight: .regular))
            .foregroundStyle(.white)
            .shadow(color: .black.opacity(0.35), radius: 1.5, x: 1, y: 1)
            .overlay {
                Image(systemName: "hand.point.up.left")
                    .font(.system(size: 58, weight: .regular))
                    .foregroundStyle(Color(red: 96 / 255, green: 91 / 255, blue: 80 / 255))
            }
            .scaleEffect(isTapping ? 0.93 : 1)
            .offset(x: isTapping ? -5 : 0, y: isTapping ? -7 : 0)
            .task {
                withAnimation(.easeInOut(duration: 0.65).repeatForever(autoreverses: true)) {
                    isTapping = true
                }
            }
    }
}
