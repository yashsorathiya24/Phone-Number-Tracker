//
//  TrackerLogo.swift
//  Phone Number Tracker
//

import SwiftUI

struct TrackerLogo: View {
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
