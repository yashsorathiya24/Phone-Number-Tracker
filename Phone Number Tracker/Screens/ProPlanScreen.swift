//
//  ProPlanScreen.swift
//  Phone Number Tracker
//

import SwiftUI
import Combine

// MARK: - Main Screen

struct ProPlanScreen: View {
    var onContinue: () -> Void

    @State private var currentSlide = 0
    @State private var selectedPlan = 1  // 0=weekly, 1=yearly, 2=monthly
    private let autoScrollTimer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // ── Scrolling Header Slides
                headerCarousel
                    .frame(height: 260)

                // ── White card body
                VStack(spacing: 0) {
                    // Features list
                    featuresSection
                        .padding(.horizontal, 24)
                        .padding(.top, 26)

                    // Pricing plans
                    pricingSection
                        .padding(.horizontal, 16)
                        .padding(.top, 24)

                    Spacer(minLength: 24)

                    // Continue button
                    continueButton
                        .padding(.horizontal, 24)
                        .padding(.bottom, 36)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .clipShape(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                )
                .ignoresSafeArea(edges: .bottom)
                .offset(y: -30)
            }

            // X dismiss button
            Button(action: onContinue) {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
            }
            .buttonStyle(.plain)
            .padding(.top, 52)
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onReceive(autoScrollTimer) { _ in
            withAnimation(.easeInOut(duration: 0.55)) {
                currentSlide = (currentSlide + 1) % 3
            }
        }
    }

    // MARK: - Header Carousel

    private var headerCarousel: some View {
        ZStack {
            ForEach(0..<3) { idx in
                slideView(for: idx)
                    .opacity(currentSlide == idx ? 1 : 0)
                    .animation(.easeInOut(duration: 0.55), value: currentSlide)
            }
        }
    }

    @ViewBuilder
    private func slideView(for index: Int) -> some View {
        switch index {
        case 0:  Slide0View(currentSlide: $currentSlide)
        case 1:  Slide1View(currentSlide: $currentSlide)
        default: Slide2View(currentSlide: $currentSlide)
        }
    }

    // MARK: - Features

    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            featureRow("Ad-Free Experience")
            featureRow("Full Access to All Premium Tools")
            featureRow("Unlimited Phone Number Tracking")
            featureRow("Unlimited Location Searches")
            featureRow("Faster Results & Better Accuracy")
            featureRow("Early Access to New Features")
            featureRow("Premium Support 24/7")
        }
    }

    private func featureRow(_ text: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color(red: 45 / 255, green: 130 / 255, blue: 245 / 255))
                    .frame(width: 26, height: 26)
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
            }
            Text(text)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 22 / 255, green: 24 / 255, blue: 30 / 255))
        }
    }

    // MARK: - Pricing

    private var pricingSection: some View {
        VStack(spacing: 16) {
            // "Most Popular" label above yearly card
            HStack {
                Spacer()
                Text("Most Popular")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color(red: 40 / 255, green: 175 / 255, blue: 100 / 255))
                    .clipShape(Capsule())
                Spacer()
            }

            HStack(spacing: 8) {
                // Weekly
                planCard(
                    title: "Weekly\nPlan",
                    subtitle: "Billed every\nweek",
                    price: "₹280",
                    originalPrice: nil,
                    badge: nil,
                    isSelected: selectedPlan == 0,
                    isCenter: false
                ) { selectedPlan = 0 }
                .frame(maxWidth: .infinity)

                // Yearly (center — highlighted)
                planCard(
                    title: "Yearly\nPlan",
                    subtitle: "Billed every\nyear",
                    price: "₹2,275",
                    originalPrice: "₹4,550",
                    badge: "50% OFF",
                    isSelected: selectedPlan == 1,
                    isCenter: true
                ) { selectedPlan = 1 }
                .frame(maxWidth: .infinity)

                // Monthly
                planCard(
                    title: "Monthly\nPlan",
                    subtitle: "Billed every\nmonth",
                    price: "₹470",
                    originalPrice: nil,
                    badge: nil,
                    isSelected: selectedPlan == 2,
                    isCenter: false
                ) { selectedPlan = 2 }
                .frame(maxWidth: .infinity)
            }
        }
    }

    private func planCard(
        title: String,
        subtitle: String,
        price: String,
        originalPrice: String?,
        badge: String?,
        isSelected: Bool,
        isCenter: Bool,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(action: onTap) {
            ZStack(alignment: .top) {
                VStack(spacing: 4) {
                    Spacer().frame(height: badge != nil ? 18 : 8)

                    Text(title)
                        .font(.system(size: isCenter ? 15 : 14, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(isCenter ? Color(red: 40 / 255, green: 120 / 255, blue: 235 / 255) : Color(red: 22 / 255, green: 24 / 255, blue: 30 / 255))

                    Text(subtitle)
                        .font(.system(size: 10.5, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundStyle(Color(red: 120 / 255, green: 124 / 255, blue: 135 / 255))
                        .lineSpacing(1)

                    Spacer()

                    Text(price)
                        .font(.system(size: isCenter ? 24 : 20, weight: .heavy, design: .rounded))
                        .foregroundStyle(isCenter ? Color(red: 40 / 255, green: 120 / 255, blue: 235 / 255) : Color(red: 22 / 255, green: 24 / 255, blue: 30 / 255))

                    if let orig = originalPrice {
                        Text(orig)
                            .font(.system(size: 12, design: .rounded))
                            .foregroundStyle(Color.gray)
                            .strikethrough(true, color: .gray)
                    }

                    Spacer().frame(height: 12)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 156)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(
                            isCenter
                                ? Color(red: 40 / 255, green: 120 / 255, blue: 235 / 255)
                                : Color(red: 220 / 255, green: 224 / 255, blue: 232 / 255),
                            lineWidth: isCenter ? 2 : 1.2
                        )
                )
                .shadow(color: isCenter ? Color.blue.opacity(0.12) : Color.clear, radius: 6, x: 0, y: 3)

                // Badge pill at top
                if let badge = badge {
                    Text(badge)
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(red: 40 / 255, green: 120 / 255, blue: 235 / 255))
                        .clipShape(Capsule())
                        .offset(y: -14)
                }
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Continue Button

    private var continueButton: some View {
        Button(action: onContinue) {
            HStack(spacing: 10) {
                Text("Continue")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 70 / 255, green: 155 / 255, blue: 255 / 255),
                        Color(red: 35 / 255, green: 105 / 255, blue: 245 / 255)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(Capsule())
            .shadow(color: Color.blue.opacity(0.30), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Slide 0: Ad-Free Experience (Blue)

private struct Slide0View: View {
    @Binding var currentSlide: Int

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 90 / 255, green: 150 / 255, blue: 245 / 255),
                    Color(red: 55 / 255, green: 115 / 255, blue: 240 / 255)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: .top)

            VStack(spacing: 0) {
                Spacer().frame(height: 60)

                HStack(alignment: .center, spacing: 20) {
                    // Crown illustration
                    Image(systemName: "crown.fill")
                        .font(.system(size: 96))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color(red: 255 / 255, green: 225 / 255, blue: 60 / 255),
                                    Color(red: 255 / 255, green: 170 / 255, blue: 20 / 255)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: Color.black.opacity(0.18), radius: 8, x: 0, y: 4)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ad-Free\nExperience")
                            .font(.system(size: 26, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .lineSpacing(2)

                        Text("Enjoy seamless tracking without\nannoying interruptions")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundStyle(Color.white.opacity(0.88))
                            .lineSpacing(2)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                // Dots indicator
                SlideDotsView(currentSlide: currentSlide)
                    .padding(.bottom, 45)
            }
        }
    }
}

// MARK: - Slide 1: All Premium Tools Unlocked (Green)

private struct Slide1View: View {
    @Binding var currentSlide: Int

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 80 / 255, green: 185 / 255, blue: 115 / 255),
                    Color(red: 45 / 255, green: 155 / 255, blue: 80 / 255)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: .top)

            VStack(spacing: 0) {
                Spacer().frame(height: 60)

                HStack(alignment: .center, spacing: 20) {
                    // GPS icon
                    Image("ic_gpstool")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.black.opacity(0.22), radius: 10, x: 0, y: 5)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("All Premium Tools\nUnlocked")
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .lineSpacing(2)

                        Text("GPS tools, contacts, and nearby\nplaces at your fingertips")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundStyle(Color.white.opacity(0.88))
                            .lineSpacing(2)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                SlideDotsView(currentSlide: currentSlide)
                    .padding(.bottom, 45)
            }
        }
    }
}

// MARK: - Slide 2: Track Any Number (Orange/Red)

private struct Slide2View: View {
    @Binding var currentSlide: Int

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 255 / 255, green: 115 / 255, blue: 70 / 255),
                    Color(red: 240 / 255, green: 70 / 255, blue: 55 / 255)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: .top)

            VStack(spacing: 0) {
                Spacer().frame(height: 60)

                HStack(alignment: .center, spacing: 20) {
                    // Locator icon
                    Image("ic_locator")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                        .shadow(color: Color.black.opacity(0.22), radius: 10, x: 0, y: 5)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Track Any\nNumber")
                            .font(.system(size: 26, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .lineSpacing(2)

                        Text("Locate phone numbers\nworldwide with premium accuracy")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundStyle(Color.white.opacity(0.88))
                            .lineSpacing(2)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                SlideDotsView(currentSlide: currentSlide)
                    .padding(.bottom, 45)
            }
        }
    }
}

// MARK: - Slide Dots

private struct SlideDotsView: View {
    let currentSlide: Int

    var body: some View {
        HStack(spacing: 7) {
            ForEach(0..<3) { idx in
                Circle()
                    .fill(idx == currentSlide ? Color.white : Color.white.opacity(0.4))
                    .frame(width: idx == currentSlide ? 9 : 7, height: idx == currentSlide ? 9 : 7)
                    .animation(.easeInOut(duration: 0.25), value: currentSlide)
            }
        }
    }
}

#Preview {
    ProPlanScreen(onContinue: {})
}
