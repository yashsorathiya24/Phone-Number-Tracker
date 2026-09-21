//
//  MockAdStrip.swift
//  Phone Number Tracker
//

import SwiftUI

struct MockAdStrip: View {
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
