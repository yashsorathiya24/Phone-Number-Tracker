//
//  SettingsScreen.swift
//  Phone Number Tracker
//

import SwiftUI
import StoreKit
import SafariServices

struct SettingsScreen: View {
    var onBack: () -> Void

    @State private var showProScreen = false
    @State private var showLanguageScreen = false
    @State private var showPrivacyScreen = false
    @State private var showFeedbackSheet = false
    @State private var showShareSheet = false
    @EnvironmentObject var languageManager: AppLanguageManager

    var body: some View {
        NavigationStack {
            ZStack {
                TrackerTheme.background
                    .ignoresSafeArea()

            VStack(spacing: 0) {
                // Navigation Header
                headerView
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 20)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        // Upgrade to PRO Banner
                        proBannerButton

                        // Settings Item Cards
                        VStack(spacing: 14) {
                            settingsCard(title: "Language") {
                                LanguageSettingsIcon()
                            } action: {
                                showLanguageScreen = true
                            }

                            settingsCard(title: "Share App") {
                                ShareSettingsIcon()
                            } action: {
                                presentShareSheet()
                            }

                            settingsCard(title: "Privacy Policy") {
                                PrivacySettingsIcon()
                            } action: {
                                showPrivacyScreen = true
                            }

                            settingsCard(title: "Rate Us") {
                                RateUsSettingsIcon()
                            } action: {
                                requestReview()
                            }

                            settingsCard(title: "Feedback") {
                                FeedbackSettingsIcon()
                            } action: {
                                showFeedbackSheet = true
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationDestination(isPresented: $showLanguageScreen) {
            LanguageScreen(isFromSettings: true) {
                showLanguageScreen = false
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $showPrivacyScreen) {
            PrivacyPolicyScreen()
        }
        .navigationDestination(isPresented: $showProScreen) {
            ProPlanScreen {
                showProScreen = false
            }
            .navigationBarBackButtonHidden(true)
        }
        .sheet(isPresented: $showFeedbackSheet) {
            FeedbackSheet()
        }
        }
    }

    // MARK: - Header
    private var headerView: some View {
        ZStack {
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(TrackerTheme.ink)
                        .frame(width: 42, height: 42)
                        .background(Color.white.opacity(0.82))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .buttonStyle(.plain)

                Spacer()
            }

            Text("Settings")
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundStyle(TrackerTheme.ink)
        }
    }

    // MARK: - PRO Banner Button
    private var proBannerButton: some View {
        Button {
            showProScreen = true
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    TrackerTheme.coral,
                                    TrackerTheme.amber
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 50, height: 50)
                        .shadow(color: TrackerTheme.coral.opacity(0.2), radius: 10, x: 0, y: 5)

                    Image(systemName: "crown.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text("Upgrade to PRO")
                        .font(.system(size: 19, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)

                    Text("Remove ads and unlock all location")
                        .font(.system(size: 13.5, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.white.opacity(0.82))
                        .lineLimit(2)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.horizontal, 16)
            .frame(minHeight: 82)
            .background(
                LinearGradient(
                    colors: [
                        TrackerTheme.navy,
                        TrackerTheme.indigo,
                        TrackerTheme.teal
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: TrackerTheme.navy.opacity(0.16), radius: 16, x: 0, y: 8)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Reusable Settings Card
    private func settingsCard<Icon: View>(
        title: LocalizedStringKey,
        @ViewBuilder icon: () -> Icon,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 18) {
                icon()
                    .frame(width: 38, height: 38)

                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(TrackerTheme.ink)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 15, weight: .heavy))
                    .foregroundStyle(TrackerTheme.teal)
            }
            .padding(.horizontal, 20)
            .frame(height: 72)
            .background(Color.white.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(TrackerTheme.stroke.opacity(0.9), lineWidth: 1)
            )
            .shadow(color: TrackerTheme.navy.opacity(0.04), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(.plain)
    }

    private func presentShareSheet() {
        let appMessage = "Check out Phone Number Tracker - Locate phone numbers and manage your favorite tools!"
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else { return }

        let activityVC = UIActivityViewController(activityItems: [appMessage], applicationActivities: nil)
        rootVC.present(activityVC, animated: true)
    }

    private func requestReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}

// MARK: - Settings Icons Matching Screenshots

struct LanguageSettingsIcon: View {
    var body: some View {
        ZStack {
            // Front bubble
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 28, height: 24)
                .overlay(
                    Text("A")
                        .font(.system(size: 13, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                )
                .offset(x: -4, y: 4)

            // Back bubble with Chinese/Japanese translation character
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(Color(red: 90 / 255, green: 165 / 255, blue: 250 / 255))
                .frame(width: 24, height: 20)
                .overlay(
                    Text("文")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                )
                .offset(x: 6, y: -5)
        }
    }
}

struct ShareSettingsIcon: View {
    var body: some View {
        ZStack {
            // Connecting branch lines
            Path { path in
                path.move(to: CGPoint(x: 10, y: 19))
                path.addLine(to: CGPoint(x: 26, y: 11))
                path.move(to: CGPoint(x: 10, y: 19))
                path.addLine(to: CGPoint(x: 26, y: 27))
            }
            .stroke(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255), lineWidth: 3.5)

            // Node circles
            Circle()
                .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 10, height: 10)
                .offset(x: -9, y: 0)

            Circle()
                .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 10, height: 10)
                .offset(x: 8, y: -8)

            Circle()
                .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 10, height: 10)
                .offset(x: 8, y: 8)
        }
        .frame(width: 36, height: 36)
    }
}

struct PrivacySettingsIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "lock.fill")
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
        }
    }
}

struct RateUsSettingsIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))

            // Sparkles
            Circle()
                .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 3.5, height: 3.5)
                .offset(x: 13, y: -10)

            Circle()
                .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 3, height: 3)
                .offset(x: -12, y: -10)

            Circle()
                .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 3, height: 3)
                .offset(x: 12, y: 9)

            Circle()
                .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 3, height: 3)
                .offset(x: -12, y: 9)
        }
    }
}

struct FeedbackSettingsIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "text.bubble.fill")
                .font(.system(size: 23, weight: .bold))
                .foregroundStyle(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
        }
    }
}

// MARK: - Settings Modals

struct ProUpgradeView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Crown icon
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 255 / 255, green: 190 / 255, blue: 45 / 255),
                                    Color(red: 255 / 255, green: 140 / 255, blue: 15 / 255)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 80, height: 80)

                    Image(systemName: "crown.fill")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.white)
                }
                .padding(.top, 28)

                VStack(spacing: 8) {
                    Text("Unlock Premium")
                        .font(.system(size: 26, weight: .heavy, design: .rounded))

                    Text("Get the best phone tracking experience without limits")
                        .font(.system(size: 15, design: .rounded))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }

                VStack(alignment: .leading, spacing: 14) {
                    proFeatureRow(icon: "nosign", text: "100% Ad-Free Experience")
                    proFeatureRow(icon: "map.fill", text: "Unlimited Location Pinpointing")
                    proFeatureRow(icon: "globe", text: "Worldwide Carrier & STD Codes")
                    proFeatureRow(icon: "bolt.shield.fill", text: "Real-time Live Updates & Alerts")
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 247 / 255, green: 249 / 255, blue: 253 / 255))
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding(.horizontal, 20)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Continue with PRO")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 255 / 255, green: 175 / 255, blue: 20 / 255),
                                    Color(red: 255 / 255, green: 135 / 255, blue: 10 / 255)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .clipShape(Capsule())
                        .shadow(color: Color.orange.opacity(0.35), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
            .navigationTitle("Upgrade to PRO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func proFeatureRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                .frame(width: 24)

            Text(text)
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 35 / 255, green: 38 / 255, blue: 45 / 255))
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = false
        let vc = SFSafariViewController(url: url, configuration: config)
        vc.preferredControlTintColor = UIColor(red: 45/255, green: 130/255, blue: 245/255, alpha: 1)
        return vc
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

struct PrivacyPolicyScreen: View {
    @Environment(\.dismiss) private var dismiss
    private let privacyURL = URL(string: "https://phonelocator.live/phone-locator-privacy-policy/")!

    var body: some View {
        SafariView(url: privacyURL)
            .ignoresSafeArea()
            .navigationTitle("Privacy Policy")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
            }
    }
}

struct FeedbackSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var feedbackText = ""
    @State private var sent = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if sent {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.green)
                    Text("Thank You!")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                    Text("Your feedback helps us make Phone Number Tracker better.")
                        .font(.system(size: 15, design: .rounded))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                    Spacer()
                } else {
                    Text("We'd love to hear your thoughts, feature suggestions, or issue reports.")
                        .font(.system(size: 15, design: .rounded))
                        .foregroundStyle(.secondary)
                        .padding(.top, 10)

                    TextEditor(text: $feedbackText)
                        .padding(10)
                        .frame(height: 160)
                        .background(Color(red: 245 / 255, green: 247 / 255, blue: 250 / 255))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )

                    Spacer()

                    Button {
                        sent = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dismiss()
                        }
                    } label: {
                        Text("Submit Feedback")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                            .clipShape(Capsule())
                    }
                    .padding(.bottom, 20)
                }
            }
            .padding(.horizontal, 20)
            .navigationTitle("Feedback")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsScreen(onBack: {})
}
