import SwiftUI

struct MockMap: View {
    var body: some View {
        ZStack {
            Color(red: 0.91, green: 0.94, blue: 0.95)
            Canvas { context, size in
                for i in stride(from: -size.height, through: size.width + size.height, by: 52) {
                    var road = Path(); road.move(to: CGPoint(x: i, y: 0)); road.addLine(to: CGPoint(x: i + size.height, y: size.height)); context.stroke(road, with: .color(.white.opacity(0.8)), lineWidth: 10)
                }
                var river = Path(); river.move(to: CGPoint(x: size.width * 0.7, y: 0)); river.addCurve(to: CGPoint(x: size.width * 0.25, y: size.height), control1: CGPoint(x: size.width * 0.45, y: size.height * 0.3), control2: CGPoint(x: size.width * 0.85, y: size.height * 0.65)); context.stroke(river, with: .color(.cyan.opacity(0.25)), lineWidth: 34)
            }
            Image(systemName: "bicycle.circle.fill").font(.system(size: 54)).foregroundStyle(.white, Color.accentColor).shadow(radius: 10)
        }.clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}
