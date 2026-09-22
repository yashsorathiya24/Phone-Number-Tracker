//
//  OnboardingPageView.swift
//  Phone Number Tracker
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    let controls: AnyView
    var isAdLoaded: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            visual
                .padding(.top, 28)

            Spacer(minLength: 36)

            textBlock
                .padding(.horizontal, 24)

//            Spacer(minLength: 10)

            controls
                .padding(.horizontal, 22)
                .padding(.bottom, isAdLoaded ? 0 : 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeInOut(duration: 0.3), value: isAdLoaded)
    }

    private var textBlock: some View {
        VStack(spacing: 10) {
            Text(LocalizedStringKey(page.title))
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color(red: 18 / 255, green: 18 / 255, blue: 22 / 255))
                .multilineTextAlignment(.center)
                .lineSpacing(2)
                .minimumScaleFactor(0.65)
                .lineLimit(3)
                .frame(maxWidth: 320)

            Text(LocalizedStringKey(page.subtitle))
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color(red: 88 / 255, green: 92 / 255, blue: 102 / 255))
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .minimumScaleFactor(0.7)
                .lineLimit(5)
                .frame(maxWidth: 310)
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
