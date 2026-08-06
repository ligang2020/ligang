import SwiftUI

struct Sparkline: View {
    let values: [CGFloat]
    var tint: Color = .accentColor
    var body: some View {
        GeometryReader { proxy in
            let maxValue = values.max() ?? 1; let minValue = values.min() ?? 0
            Path { path in
                for index in values.indices {
                    let x = proxy.size.width * CGFloat(index) / CGFloat(max(values.count - 1, 1))
                    let normalized = (values[index] - minValue) / max(maxValue - minValue, 0.01)
                    let y = proxy.size.height * (1 - normalized)
                    index == values.startIndex ? path.move(to: CGPoint(x: x, y: y)) : path.addLine(to: CGPoint(x: x, y: y))
                }
            }.stroke(tint, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
        }
    }
}
