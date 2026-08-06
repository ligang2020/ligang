import SwiftUI

enum Motion {
    static let press = Animation.spring(response: 0.22, dampingFraction: 0.86)
    static let state = Animation.spring(response: 0.34, dampingFraction: 0.84)
    static let transition = Animation.easeOut(duration: 0.2)
}

struct PressScaleButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.96 : 1)
            .opacity(configuration.isPressed ? 0.82 : 1)
            .animation(reduceMotion ? .easeOut(duration: 0.1) : Motion.press, value: configuration.isPressed)
    }
}
