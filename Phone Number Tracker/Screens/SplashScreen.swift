//
//  SplashScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct SplashScreen: View {
    @State private var progress: CGFloat = 0

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Blue background
                Color(red: 30 / 255, green: 130 / 255, blue: 245 / 255)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    // App Icon
                    TrackerLogo(style: .roundedSquare)
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())

                    Spacer().frame(height: 32)

                    // App Title
                    Text("Phone Number Tracker")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)

                    Spacer().frame(height: 10)

                    // Subtitle
                    Text("Locate any number worldwide")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))

                    Spacer()

                    // Progress Bar — matching BlueLoadingScreen (width: proxy.size.width * 0.6)
                    VStack(spacing: 19) {
                        LoadingBar(progress: progress)
                            .frame(width: proxy.size.width * 0.6, height: 6)

                        Text("This action may contain ads")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, max(proxy.safeAreaInsets.bottom + 52, 66))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 2.2)) {
                progress = 1.0
            }
        }
    }
}

