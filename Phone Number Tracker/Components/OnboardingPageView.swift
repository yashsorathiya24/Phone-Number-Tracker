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
                .padding(.top, 34)

            Spacer(minLength: 36)

            textBlock
                .padding(.horizontal, 24)
                .padding(.bottom, 22)

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
                .font(.system(size: 31, weight: .heavy, design: .rounded))
                .foregroundStyle(TrackerTheme.ink)
                .multilineTextAlignment(.center)
                .lineSpacing(2)
                .minimumScaleFactor(0.65)
                .lineLimit(3)
                .frame(maxWidth: 330)

            Text(LocalizedStringKey(page.subtitle))
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(TrackerTheme.muted)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .minimumScaleFactor(0.7)
                .lineLimit(5)
                .frame(maxWidth: 320)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 18)
        .background(Color.white.opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .stroke(TrackerTheme.stroke.opacity(0.55), lineWidth: 1)
        )
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
