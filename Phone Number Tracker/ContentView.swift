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
    @State private var showingSettings = false
    @StateObject private var favoritesManager = FavoritesManager()

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
                OnboardingScreen(language: selectedLanguage) {
                    stage = .proPlan
                }
                .transition(.opacity)
            case .proPlan:
                ProPlanScreen {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        stage = .home
                    }
                }
                .transition(.opacity)
            case .home:
                if showingSettings {
                    SettingsScreen {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            showingSettings = false
                        }
                    }
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                } else {
                    HomeScreen {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            showingSettings = true
                        }
                    }
                    .transition(.opacity)
                }
            }
        }
        .environmentObject(favoritesManager)
        .animation(.easeInOut(duration: 0.35), value: stage)
        .animation(.easeInOut(duration: 0.25), value: showingSettings)
        .task {
            if ProcessInfo.processInfo.arguments.contains("-skipToHome") {
                stage = .home
                return
            }
            if ProcessInfo.processInfo.arguments.contains("-skipToSettings") {
                stage = .home
                showingSettings = true
                return
            }
            if ProcessInfo.processInfo.arguments.contains("-skipToProPlan") {
                stage = .proPlan
                return
            }
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
