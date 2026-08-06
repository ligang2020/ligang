import SwiftUI

struct MetricCard: View {
    let icon: String
    let title: String
    let value: String
    let unit: String
    var tint: Color = .accentColor
    var body: some View {
        GlassCard(padding: 14) {
            VStack(alignment: .leading, spacing: 9) {
                Image(systemName: icon).font(.system(size: 15, weight: .semibold)).foregroundStyle(tint)
                Text(title).font(.caption).foregroundStyle(.secondary)
                HStack(alignment: .firstTextBaseline, spacing: 3) { Text(value).font(.title3.weight(.bold).monospacedDigit()); Text(unit).font(.caption).foregroundStyle(.secondary) }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
