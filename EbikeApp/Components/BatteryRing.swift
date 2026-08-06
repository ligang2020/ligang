import SwiftUI

struct BatteryRing: View {
    let value: Double
    var size: CGFloat = 148
    var lineWidth: CGFloat = 13
    var label: String = "电量"
    @State private var progress = 0.0

    var body: some View {
        ZStack {
            Circle().stroke(Color.primary.opacity(0.08), lineWidth: lineWidth)
            Circle().trim(from: 0, to: progress).stroke(AngularGradient(colors: [.blue, .cyan, .green], center: .center), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)).rotationEffect(.degrees(-90))
            VStack(spacing: 1) { Text("\(Int(value * 100))%").font(.system(size: size * 0.25, weight: .bold, design: .rounded)).contentTransition(.numericText()) ; Text(label).font(.caption).foregroundStyle(.secondary) }
        }.frame(width: size, height: size).onAppear { withAnimation(.easeOut(duration: 1.0)) { progress = value } }
    }
}
