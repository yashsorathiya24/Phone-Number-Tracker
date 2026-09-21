//
//  OnboardingPageView.swift
//  Phone Number Tracker
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    let controls: AnyView

    var body: some View {
        VStack(spacing: 0) {
            visual
                .padding(.top, 6)

            textBlock
                .padding(.horizontal, 28)
                .padding(.top, 16)

            controls
                .padding(.horizontal, 22)
                .padding(.top, 26)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    private var textBlock: some View {
        VStack(spacing: 10) {
            Text(page.title)
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(Color(red: 18 / 255, green: 18 / 255, blue: 22 / 255))
                .multilineTextAlignment(.center)
                .lineSpacing(0)
                .minimumScaleFactor(0.7)
                .lineLimit(3)

            Text(page.subtitle)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color(red: 130 / 255, green: 130 / 255, blue: 136 / 255))
                .multilineTextAlignment(.center)
                .lineSpacing(3)
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
