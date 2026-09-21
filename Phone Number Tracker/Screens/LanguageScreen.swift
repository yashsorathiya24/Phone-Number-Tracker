//
//  LanguageScreen.swift
//  Phone Number Tracker
//

import SwiftUI

struct LanguageScreen: View {
    @Binding var selectedLanguage: String
    let onContinue: () -> Void

    @State private var showsConfirmCheck = false
    @State private var confirmTask: Task<Void, Never>?

    private let languages = [
        "Chinese",
        "Spanish",
        "French",
        "English",
        "Russian",
        "Hindi",
        "Urdu",
        "Portuguese (Brazil)",
        "German",
        "Japanese",
        "Turkish",
        "Vietnamese",
        "Czech"
    ]

    var body: some View {
        ZStack {
            Color.languageBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 9) {
                        ForEach(languages, id: \.self) { language in
                            LanguageRow(
                                title: language,
                                isSelected: selectedLanguage == language
                            ) {
                                selectedLanguage = language
                                scheduleConfirmCheck()
                            }
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, 30)
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showsConfirmCheck)
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
            .disabled(!showsConfirmCheck || selectedLanguage.isEmpty)
            .buttonStyle(.plain)
            .padding(.trailing, 15)
        }
        .padding(.horizontal, 22)
        .padding(.top, 43)
        .padding(.bottom, 31)
    }

    private func scheduleConfirmCheck() {
        confirmTask?.cancel()
        showsConfirmCheck = false
        confirmTask = Task {
            try? await Task.sleep(for: .seconds(1))
            guard !Task.isCancelled else { return }
            showsConfirmCheck = true
        }
    }
}
