//
//  OnboardingPageView.swift
//  Phone Number Tracker
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    let controls: AnyView

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                visual
                    .padding(.top, max(proxy.safeAreaInsets.top, 20) + 8)

                textBlock
                    .padding(.horizontal, 32)
                    .padding(.top, 24)

                Spacer(minLength: 16)

                controls
                    .padding(.horizontal, 20)
                    .padding(.bottom, max(proxy.safeAreaInsets.bottom, 16) + 8)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }

    private var textBlock: some View {
        VStack(spacing: 12) {
            Text(page.title)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 24 / 255, green: 25 / 255, blue: 31 / 255))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .minimumScaleFactor(0.7)
                .lineLimit(3)

            Text(page.subtitle)
                .font(.system(size: 19, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 82 / 255, green: 82 / 255, blue: 88 / 255))
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .minimumScaleFactor(0.7)
                .lineLimit(4)
        }
    }

    @ViewBuilder
    private var visual: some View {
        switch page {
        case .details:
            DetailsLookupVisual()
        case .search:
            WorldwideSearchVisual()
        case .location:
            LiveLocationVisual()
        case .history:
            HistoryLookupVisual()
        }
    }
}
