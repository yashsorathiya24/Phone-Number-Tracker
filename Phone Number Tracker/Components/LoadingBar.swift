//
//  LoadingBar.swift
//  Phone Number Tracker
//

import SwiftUI

struct LoadingBar: View {
    var progress: CGFloat? = nil
    @State private var internalProgress: CGFloat = 0

    private var activeProgress: CGFloat {
        progress ?? internalProgress
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                // Background Track
                Capsule()
                    .fill(Color.white.opacity(0.3))

                // Progress Fill — cleanly contained within track bounds
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 100 / 255, green: 80 / 255, blue: 160 / 255),
                                Color(red: 160 / 255, green: 100 / 255, blue: 200 / 255)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: proxy.size.width * max(0, min(1, activeProgress)))
            }
            .clipShape(Capsule())
            .onAppear {
                if progress == nil {
                    internalProgress = 0
                    withAnimation(.linear(duration: 2.2)) {
                        internalProgress = 1.0
                    }
                }
            }
        }
    }
}


