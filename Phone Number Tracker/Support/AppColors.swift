//
//  AppColors.swift
//  Phone Number Tracker
//

import SwiftUI

extension Color {
    static let trackerBlue = Color(red: 30 / 255, green: 128 / 255, blue: 239 / 255)
    static let languageBackground = Color(red: 239 / 255, green: 243 / 255, blue: 244 / 255)
    static let primaryText = Color(red: 48 / 255, green: 49 / 255, blue: 61 / 255)
    static let rowStroke = Color(red: 225 / 255, green: 226 / 255, blue: 228 / 255)
    static let radioStroke = Color(red: 240 / 255, green: 240 / 255, blue: 241 / 255)
    static let selectedStroke = Color(red: 154 / 255, green: 157 / 255, blue: 164 / 255)
    static let callGreen = Color(red: 54 / 255, green: 208 / 255, blue: 129 / 255)
}

enum TrackerTheme {
    static let ink = Color(red: 19 / 255, green: 24 / 255, blue: 38 / 255)
    static let muted = Color(red: 98 / 255, green: 107 / 255, blue: 128 / 255)
    static let canvas = Color(red: 244 / 255, green: 247 / 255, blue: 250 / 255)
    static let panel = Color.white.opacity(0.92)
    static let stroke = Color(red: 214 / 255, green: 222 / 255, blue: 232 / 255)
    static let teal = Color(red: 14 / 255, green: 171 / 255, blue: 164 / 255)
    static let coral = Color(red: 247 / 255, green: 91 / 255, blue: 82 / 255)
    static let amber = Color(red: 245 / 255, green: 166 / 255, blue: 35 / 255)
    static let indigo = Color(red: 63 / 255, green: 86 / 255, blue: 191 / 255)
    static let navy = Color(red: 18 / 255, green: 31 / 255, blue: 55 / 255)

    static var background: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 239 / 255, green: 250 / 255, blue: 249 / 255),
                Color(red: 246 / 255, green: 248 / 255, blue: 252 / 255),
                Color(red: 255 / 255, green: 247 / 255, blue: 239 / 255)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
