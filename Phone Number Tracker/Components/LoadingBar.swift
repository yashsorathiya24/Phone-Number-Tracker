//
//  LoadingBar.swift
//  Phone Number Tracker
//

import SwiftUI

struct LoadingBar: View {
    @State private var offset: CGFloat = -1

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.white)

                Capsule()
                    .fill(Color(red: 122 / 255, green: 94 / 255, blue: 165 / 255))
                    .frame(width: proxy.size.width * 0.22)
                    .offset(x: offset * proxy.size.width)
            }
            .task {
                withAnimation(.linear(duration: 1.35).repeatForever(autoreverses: false)) {
                    offset = 1.05
                }
            }
        }
    }
}
