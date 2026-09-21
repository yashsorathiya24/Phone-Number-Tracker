//
//  AdLoadingScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct AdLoadingScreen: View {
    var body: some View {
        ZStack {
            BlueLoadingScreen()
                .brightness(-0.45)

            Color(red: 10 / 255, green: 20 / 255, blue: 35 / 255)
                .opacity(0.83)
                .ignoresSafeArea()

            GeometryReader { proxy in
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: proxy.size.height * 0.42)

                    PhonePulseIcon()
                        .frame(width: proxy.size.width * 0.32, height: proxy.size.width * 0.32)

                    Text("Loading ad, Please wait...")
                        .font(.system(size: proxy.size.width * 0.042, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.top, proxy.size.height * 0.11)

                    Spacer()

                    MockAdStrip()
                        .frame(height: 78)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
