import SwiftUI

struct GlassCard<Content: View>: View {
    var padding: CGFloat = 18
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(padding)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.8))
    }
}

struct StatusPill: View {
    let icon: String
    let title: String
    let value: String
    var tint: Color = .green

    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: icon).font(.system(size: 12, weight: .semibold)).foregroundStyle(tint)
            VStack(alignment: .leading, spacing: 1) {
                Text(title).font(.caption2).foregroundStyle(.secondary)
                Text(value).font(.caption.weight(.semibold))
            }
        }
        .padding(.horizontal, 11).padding(.vertical, 8)
        .background(Color.primary.opacity(0.055), in: Capsule())
    }
}

struct SectionHeader: View {
    let title: String
    var action: String? = nil
    var onAction: (() -> Void)? = nil
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title).font(.title3.weight(.bold))
            Spacer()
            if let action { Button(action) { onAction?() }.font(.subheadline.weight(.semibold)).foregroundStyle(Color.accentColor) }
        }
    }
}
