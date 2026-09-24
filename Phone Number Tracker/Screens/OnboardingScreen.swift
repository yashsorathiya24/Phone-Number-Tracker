//
//  OnboardingScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct OnboardingScreen: View {
    let language: String
    var onFinish: () -> Void = {}

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
            TrackerTheme.background
                .ignoresSafeArea()

            Image("img_number_bg")
                .resizable()
                .scaledToFill()
                .opacity(0.16)
                .ignoresSafeArea()

            LinearGradient(
                stops: [
                    .init(color: TrackerTheme.navy.opacity(0.10), location: 0.0),
                    .init(color: .clear, location: 0.35),
                    .init(color: Color.white.opacity(0.72), location: 0.62),
                    .init(color: Color.white.opacity(0.90), location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

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
                } else {
                    onFinish()
                }
            } label: {
                Text(LocalizedStringKey(selectedPage == pages.count - 1 ? copy.start : copy.next))
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .frame(height: 42)
                    .background(TrackerTheme.navy)
                    .clipShape(Capsule())
                    .shadow(color: TrackerTheme.navy.opacity(0.18), radius: 10, x: 0, y: 5)
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
