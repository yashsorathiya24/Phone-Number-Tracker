//
//  LanguageRow.swift
//  Phone Number Tracker
//

import SwiftUI

struct LanguageRow: View {
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
