//
//  ContentView.swift
//  Phone Number Tracker
//
//  Created by Yash Sorathiya  on 19/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var stage: LaunchStage = .splash
    @State private var selectedLanguage = ""

    var body: some View {
        ZStack {
            switch stage {
            case .splash:
                SplashScreen()
                    .transition(.opacity)
            case .loading:
                BlueLoadingScreen()
                    .transition(.opacity)
            case .adLoading:
                AdLoadingScreen()
                    .transition(.opacity)
            case .language:
                LanguageScreen(selectedLanguage: $selectedLanguage) {
                    stage = .onboarding
                }
                .transition(.opacity)
            case .onboarding:
                OnboardingScreen(language: selectedLanguage)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: stage)
        .task {
            if ProcessInfo.processInfo.arguments.contains("-skipToOnboarding") {
                selectedLanguage = "English"
                stage = .onboarding
                return
            }
            await runLaunchSequence()
        }
    }

    private func runLaunchSequence() async {
        guard stage == .splash else { return }
        try? await Task.sleep(for: .seconds(1.2))
        stage = .loading
        try? await Task.sleep(for: .seconds(1.9))
        stage = .adLoading
        try? await Task.sleep(for: .seconds(1.8))
        stage = .language
    }
}

#Preview {
    ContentView()
}
