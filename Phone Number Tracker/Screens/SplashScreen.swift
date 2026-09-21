//
//  SplashScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.ignoresSafeArea()

                TrackerLogo(style: .roundedSquare)
                    .frame(width: proxy.size.width * 0.45, height: proxy.size.width * 0.45)
                    .position(x: proxy.size.width / 2, y: proxy.size.height * 0.51)
            }
        }
    }
}
