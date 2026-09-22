//
//  Phone_Number_TrackerApp.swift
//  Phone Number Tracker
//
//  Created by Yash Sorathiya  on 19/09/26.
//

import SwiftUI
import Combine

class AppLanguageManager: ObservableObject {
    @Published var currentLanguage: String = ""
    
    func languageName(for code: String) -> String {
        switch code {
        case "zh-Hans": return "Chinese"
        case "es": return "Spanish"
        case "fr": return "French"
        case "ru": return "Russian"
        case "hi": return "Hindi"
        case "ur": return "Urdu"
        case "pt-BR": return "Portuguese (Brazil)"
        case "de": return "German"
        case "ja": return "Japanese"
        case "tr": return "Turkish"
        case "vi": return "Vietnamese"
        case "cs": return "Czech"
        default: return "English"
        }
    }
}

@main
struct Phone_Number_TrackerApp: App {
    @StateObject private var languageManager = AppLanguageManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(languageManager)
                .environment(\.locale, Locale(identifier: languageManager.currentLanguage))
        }
    }
}
