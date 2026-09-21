//
//  OnboardingScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct OnboardingScreen: View {
    let language: String

    @State private var selectedPage = 0

    private var copy: OnboardingLocalization {
        OnboardingLocalization.copy(for: language)
    }

    private var pages: [OnboardingPage] {
        [
            .details(title: copy.detailsTitle, subtitle: copy.detailsSubtitle),
            .location(title: copy.locationTitle, subtitle: copy.locationSubtitle),
            .search(title: copy.searchTitle, subtitle: copy.searchSubtitle),
            .history(title: copy.historyTitle, subtitle: copy.historySubtitle)
        ]
    }

    var body: some View {
        ZStack {
            NumberPatternBackground()

            TabView(selection: $selectedPage) {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    OnboardingPageView(page: page, controls: AnyView(onboardingControls))
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea(edges: .bottom)
        }
    }

    private var onboardingControls: some View {
        HStack(alignment: .center) {
            OnboardingDots(currentPage: selectedPage, pageCount: pages.count)

            Spacer()

            Button {
                if selectedPage < pages.count - 1 {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedPage += 1
                    }
                }
            } label: {
                Text(selectedPage == pages.count - 1 ? copy.start : copy.next)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color(red: 28 / 255, green: 28 / 255, blue: 32 / 255))
                    .padding(.horizontal, 20)
                    .frame(height: 32)
                    .overlay {
                        Capsule()
                            .stroke(Color(red: 32 / 255, green: 32 / 255, blue: 36 / 255), lineWidth: 1.15)
                    }
            }
            .buttonStyle(.plain)
        }
    }
}

enum OnboardingPage {
    case details(title: String, subtitle: String)
    case search(title: String, subtitle: String)
    case location(title: String, subtitle: String)
    case history(title: String, subtitle: String)

    var title: String {
        switch self {
        case .details(let title, _), .search(let title, _), .location(let title, _), .history(let title, _):
            title
        }
    }

    var subtitle: String {
        switch self {
        case .details(_, let subtitle), .search(_, let subtitle), .location(_, let subtitle), .history(_, let subtitle):
            subtitle
        }
    }
}
