import SwiftUI

struct VehicleArtwork: View {
    var compact = false
    @State private var hovering = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    var body: some View {
        ZStack {
            Circle().fill(LinearGradient(colors: [Color.blue.opacity(0.25), Color.cyan.opacity(0.02)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .blur(radius: 2)
            Image(systemName: "bicycle").font(.system(size: compact ? 86 : 158, weight: .ultraLight))
                .symbolRenderingMode(.hierarchical).foregroundStyle(Color.accentColor, Color.white.opacity(0.7))
                .shadow(color: Color.accentColor.opacity(0.25), radius: 20, y: 10)
                .rotation3DEffect(.degrees(hovering ? 2 : 0), axis: (x: 0, y: 1, z: 0))
            Image(systemName: "bolt.fill").font(.system(size: compact ? 18 : 26, weight: .bold)).foregroundStyle(.white)
                .padding(compact ? 9 : 13).background(Color.accentColor, in: Circle()).offset(x: compact ? 25 : 52, y: compact ? -25 : -55)
        }
        .frame(height: compact ? 120 : 240)
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) { hovering = true }
        }
    }
}
