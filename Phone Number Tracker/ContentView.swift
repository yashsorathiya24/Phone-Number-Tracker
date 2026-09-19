//
//  ContentView.swift
//  Phone Number Tracker
//
//  Created by Yash Sorathiya  on 19/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var stage: LaunchStage = .splash
    @State private var selectedLanguage = "English"

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
                LanguageScreen(selectedLanguage: $selectedLanguage)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: stage)
        .task {
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

private enum LaunchStage {
    case splash
    case loading
    case adLoading
    case language
}

private struct SplashScreen: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.ignoresSafeArea()

                TrackerLogo(style: .roundedSquare)
                    .frame(width: proxy.size.width * 0.45, height: proxy.size.width * 0.45)
                    .position(x: proxy.size.width / 2, y: proxy.size.height * 0.51)
            }
        }
    }
}

private struct BlueLoadingScreen: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.trackerBlue.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: proxy.size.height * 0.34)

                    TrackerLogo(style: .circle)
                        .frame(width: proxy.size.width * 0.34, height: proxy.size.width * 0.34)

                    Text("Phone Number Tracker")
                        .font(.system(size: proxy.size.width * 0.071, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.78)
                        .padding(.top, 43)
                        .padding(.horizontal, 24)

                    Text("Locate any number worldwide")
                        .font(.system(size: proxy.size.width * 0.038, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.82))
                        .padding(.top, 22)

                    Spacer()

                    VStack(spacing: 19) {
                        LoadingBar()
                            .frame(width: proxy.size.width * 0.5, height: 8)

                        Text("This action may contain ads")
                            .font(.system(size: proxy.size.width * 0.038, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .padding(.bottom, max(proxy.safeAreaInsets.bottom + 66, 88))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

private struct AdLoadingScreen: View {
    var body: some View {
        ZStack {
            BlueLoadingScreen()
                .brightness(-0.45)

            Color(red: 10 / 255, green: 20 / 255, blue: 35 / 255)
                .opacity(0.83)
                .ignoresSafeArea()

            GeometryReader { proxy in
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: proxy.size.height * 0.42)

                    PhonePulseIcon()
                        .frame(width: proxy.size.width * 0.32, height: proxy.size.width * 0.32)

                    Text("Loading ad, Please wait...")
                        .font(.system(size: proxy.size.width * 0.042, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.top, proxy.size.height * 0.11)

                    Spacer()

                    MockAdStrip()
                        .frame(height: 78)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

private struct LanguageScreen: View {
    @Binding var selectedLanguage: String
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
                HStack {
                    Text("Language")
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                        .foregroundStyle(Color.primaryText)

                    Spacer()

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
                    .padding(.trailing, 15)
                }
                .padding(.horizontal, 22)
                .padding(.top, 43)
                .padding(.bottom, 31)

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

private struct LanguageRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 30) {
                ZStack {
                    Circle()
                        .stroke(isSelected ? .black : Color.radioStroke, lineWidth: isSelected ? 4 : 2)
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Circle()
                            .fill(.black)
                            .frame(width: 10, height: 10)
                    }
                }
                .frame(width: 28, height: 28)

                Text(title)
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color.primaryText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.78)

                Spacer()
            }
            .padding(.horizontal, 37)
            .frame(height: 67)
            .background(.white)
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(isSelected ? Color.selectedStroke : Color.rowStroke, lineWidth: isSelected ? 3 : 2)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct TrackerLogo: View {
    enum Style {
        case roundedSquare
        case circle
    }

    let style: Style

    var body: some View {
        switch style {
        case .roundedSquare:
            Image("TrackerLogo")
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        case .circle:
            Image("TrackerLogo")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
        }
    }
}

private struct LoadingBar: View {
    @State private var offset: CGFloat = -1

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.white)

                Capsule()
                    .fill(Color(red: 122 / 255, green: 94 / 255, blue: 165 / 255))
                    .frame(width: proxy.size.width * 0.22)
                    .offset(x: offset * proxy.size.width)
            }
            .task {
                withAnimation(.linear(duration: 1.35).repeatForever(autoreverses: false)) {
                    offset = 1.05
                }
            }
        }
    }
}

private struct PhonePulseIcon: View {
    @State private var pulse = false

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.callGreen.opacity(0.24))
                .scaleEffect(pulse ? 1.18 : 0.92)
                .opacity(pulse ? 0 : 0.8)

            Circle()
                .fill(Color.callGreen)

            Image(systemName: "phone.fill")
                .font(.system(size: 62, weight: .bold))
                .foregroundStyle(.white)
                .rotationEffect(.degrees(-18))
        }
        .task {
            withAnimation(.easeOut(duration: 1.05).repeatForever(autoreverses: false)) {
                pulse = true
            }
        }
    }
}

private struct MockAdStrip: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .fill(.black.opacity(0.58))

            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.white.opacity(0.2))
                        .frame(width: 178, height: 10)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.yellow.opacity(0.52))
                        .frame(width: 238, height: 12)
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white.opacity(0.24), lineWidth: 1)
                        .frame(width: 176, height: 18)
                }

                Spacer()

                RoundedRectangle(cornerRadius: 5)
                    .fill(.white.opacity(0.13))
                    .frame(width: 58, height: 58)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)

            HStack(spacing: 10) {
                Image(systemName: "info.circle")
                Image(systemName: "ellipsis")
            }
            .font(.system(size: 22, weight: .semibold))
            .foregroundStyle(Color.cyan.opacity(0.75))
            .padding(.top, 9)
            .padding(.trailing, 9)
        }
    }
}

private extension Color {
    static let trackerBlue = Color(red: 30 / 255, green: 128 / 255, blue: 239 / 255)
    static let languageBackground = Color(red: 239 / 255, green: 243 / 255, blue: 244 / 255)
    static let primaryText = Color(red: 48 / 255, green: 49 / 255, blue: 61 / 255)
    static let rowStroke = Color(red: 225 / 255, green: 226 / 255, blue: 228 / 255)
    static let radioStroke = Color(red: 240 / 255, green: 240 / 255, blue: 241 / 255)
    static let selectedStroke = Color(red: 154 / 255, green: 157 / 255, blue: 164 / 255)
    static let callGreen = Color(red: 54 / 255, green: 208 / 255, blue: 129 / 255)
}

#Preview {
    ContentView()
}
