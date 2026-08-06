import SwiftUI

struct ActionTile: View {
    let icon: String
    let title: String
    let tint: Color
    let action: () -> Void
    var body: some View {
        Button { action() } label: {
            VStack(spacing: 9) {
                Image(systemName: icon).font(.system(size: 18, weight: .semibold)).foregroundStyle(tint)
                Text(title).font(.caption.weight(.semibold)).foregroundStyle(.primary)
            }.frame(maxWidth: .infinity).frame(height: 78)
                .background(Color.primary.opacity(0.045), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        }.buttonStyle(PressScaleButtonStyle())
    }
}
