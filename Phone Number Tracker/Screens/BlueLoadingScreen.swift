//
//  BlueLoadingScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct BlueLoadingScreen: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.trackerBlue.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: proxy.size.height * 0.34)

                    TrackerLogo(style: .circle)
                        .frame(width: proxy.size.width * 0.34, height: proxy.size.width * 0.34)

                    Text("Phone Number Tracker")
                        .font(.system(size: proxy.size.width * 0.071, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.78)
                        .padding(.top, 43)
                        .padding(.horizontal, 24)

                    Text("Locate any number worldwide")
                        .font(.system(size: proxy.size.width * 0.038, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.82))
                        .padding(.top, 22)

                    Spacer()

                    VStack(spacing: 19) {
                        LoadingBar()
                            .frame(width: proxy.size.width * 0.5, height: 8)

                        Text("This action may contain ads")
                            .font(.system(size: proxy.size.width * 0.038, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .padding(.bottom, max(proxy.safeAreaInsets.bottom + 66, 88))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
