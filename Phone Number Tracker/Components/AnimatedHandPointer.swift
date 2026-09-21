//
//  AnimatedHandPointer.swift
//  Phone Number Tracker
//

import SwiftUI

private struct HandSwipeValues {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var rotation: Double = 0
    var trail: Double = 0
}

struct AnimatedHandPointer: View {
    var body: some View {
        KeyframeAnimator(initialValue: HandSwipeValues(), repeating: true) { value in
            ZStack(alignment: .topLeading) {
                SwipeMotionLines()
                    .frame(width: 42, height: 26)
                    .offset(x: 50 + (26 - value.x) * 0.7, y: 0)
                    .opacity(value.trail)

                hand
                    .offset(x: value.x, y: value.y)
                    .rotationEffect(.degrees(16 + value.rotation), anchor: UnitPoint(x: 0.28, y: 0.10))
            }
            .frame(width: 70, height: 74, alignment: .topLeading)
        } keyframes: { _ in
            KeyframeTrack(\.x) {
                LinearKeyframe(0, duration: 0.75)
                CubicKeyframe(26, duration: 0.30)
                LinearKeyframe(26, duration: 0.08)
                CubicKeyframe(0, duration: 0.62)
                LinearKeyframe(0, duration: 0.55)
            }

            KeyframeTrack(\.y) {
                LinearKeyframe(0, duration: 0.75)
                CubicKeyframe(-5, duration: 0.30)
                LinearKeyframe(-5, duration: 0.08)
                CubicKeyframe(0, duration: 0.62)
                LinearKeyframe(0, duration: 0.55)
            }

            KeyframeTrack(\.rotation) {
                LinearKeyframe(0, duration: 0.75)
                CubicKeyframe(8, duration: 0.30)
                LinearKeyframe(8, duration: 0.08)
                CubicKeyframe(0, duration: 0.62)
                LinearKeyframe(0, duration: 0.55)
            }

            KeyframeTrack(\.trail) {
                LinearKeyframe(0, duration: 0.86)
                CubicKeyframe(1, duration: 0.16)
                LinearKeyframe(1, duration: 0.10)
                CubicKeyframe(0.3, duration: 0.28)
                CubicKeyframe(0, duration: 0.22)
                LinearKeyframe(0, duration: 0.68)
            }
        }
    }

    private var hand: some View {
        Image(systemName: "hand.point.up.left.fill")
            .font(.system(size: 62, weight: .regular))
            .foregroundStyle(.white)
            .shadow(color: .black.opacity(0.22), radius: 1.1, x: 0.8, y: 0.8)
            .overlay {
                Image(systemName: "hand.point.up.left")
                    .font(.system(size: 62, weight: .regular))
                    .foregroundStyle(Color(red: 110 / 255, green: 104 / 255, blue: 94 / 255))
            }
    }
}

private struct SwipeMotionLines: View {
    var body: some View {
        Canvas { context, size in
            let color = Color(red: 170 / 255, green: 164 / 255, blue: 156 / 255)
            let lines: [(y: CGFloat, start: CGFloat, length: CGFloat, lift: CGFloat)] = [
                (3.5, 10, 22, 4.5),
                (12, 2, 32, 6),
                (20.5, 8, 20, 4)
            ]

            for line in lines {
                var path = Path()
                let start = CGPoint(x: line.start, y: line.y)
                let end = CGPoint(x: line.start + line.length, y: line.y - line.lift * 0.28)
                let control = CGPoint(
                    x: (start.x + end.x) / 2,
                    y: min(start.y, end.y) - line.lift
                )
                path.move(to: start)
                path.addQuadCurve(to: end, control: control)
                context.stroke(
                    path,
                    with: .color(color),
                    style: StrokeStyle(lineWidth: 1.7, lineCap: .round)
                )
            }
        }
        .allowsHitTesting(false)
    }
}
