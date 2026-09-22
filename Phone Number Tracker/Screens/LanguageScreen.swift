//
//  LanguageScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct LanguageScreen: View {
    @EnvironmentObject var languageManager: AppLanguageManager
    var isFromSettings: Bool = false
    let onContinue: () -> Void

    @State private var showsConfirmCheck = false
    @State private var confirmTask: Task<Void, Never>?

    private let languages: [(name: String, code: String)] = [
        ("Chinese", "zh-Hans"),
        ("Spanish", "es"),
        ("French", "fr"),
        ("English", "en"),
        ("Russian", "ru"),
        ("Hindi", "hi"),
        ("Urdu", "ur"),
        ("Portuguese (Brazil)", "pt-BR"),
        ("German", "de"),
        ("Japanese", "ja"),
        ("Turkish", "tr"),
        ("Vietnamese", "vi"),
        ("Czech", "cs")
    ]

    var body: some View {
        ZStack {
            Color.languageBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 9) {
                        ForEach(languages, id: \.code) { language in
                            LanguageRow(
                                title: language.name,
                                isSelected: languageManager.currentLanguage == language.code
                            ) {
                                languageManager.currentLanguage = language.code
                                scheduleConfirmCheck()
                            }
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, 22)
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showsConfirmCheck)
        .onAppear {
            if !languageManager.currentLanguage.isEmpty {
                if isFromSettings {
                    showsConfirmCheck = true
                } else {
                    scheduleConfirmCheck()
                }
            }
        }
        .onDisappear {
            confirmTask?.cancel()
        }
    }

    private var header: some View {
        HStack {
            Text("Language")
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundStyle(Color.primaryText)

            Spacer()

            Button(action: onContinue) {
                Group {
                    if showsConfirmCheck {
                        Image(systemName: "checkmark")
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundStyle(.black)
                            .transition(.opacity.combined(with: .scale(scale: 0.9)))
                    } else {
                        Color.clear
                    }
                }
                .frame(width: 36, height: 36)
            }
            .disabled(!showsConfirmCheck || languageManager.currentLanguage.isEmpty)
            .buttonStyle(.plain)
            .padding(.trailing, 15)
        }
        .padding(.horizontal, 22)
        .padding(.top, 43)
        .padding(.bottom, 31)
    }

    private func scheduleConfirmCheck() {
        if isFromSettings {
            showsConfirmCheck = true
            return
        }
        confirmTask?.cancel()
        showsConfirmCheck = false
        confirmTask = Task {
            try? await Task.sleep(for: .seconds(1))
            guard !Task.isCancelled else { return }
            showsConfirmCheck = true
        }
    }
}
