import SwiftUI

struct RideDetailView: View {
    let ride: Ride
    private let charts: [(String, String, Color, [CGFloat])] = [
        ("速度", "21.3 km/h", .blue, [12,18,22,17,28,31,26,35,30]), ("功率", "486 W", .orange, [20,34,18,40,52,32,60,45,38]),
        ("电流", "9.2 A", .green, [8,15,12,22,19,28,16,25,20]), ("电压", "52.4 V", .purple, [54,53,53,52,52.5,52,51.8,52,51.6])
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                MockMap().frame(height: 300).overlay(alignment: .bottomLeading) { Label("12.8 km · 徐汇滨江", systemImage: "point.topleft.down.to.point.bottomright.curvepath").font(.subheadline.weight(.semibold)).padding(12).background(.regularMaterial, in: Capsule()).padding(14) }
                HStack { score("骑行", 92, .blue); score("节能", 88, .green); score("安全", 96, .orange) }
                ForEach(charts, id: \.0) { chart in GlassCard { VStack(alignment: .leading, spacing: 12) { HStack { Text(chart.0).font(.headline); Spacer(); Text(chart.1).font(.subheadline.bold()) }; Sparkline(values: chart.3, tint: chart.2).frame(height: 82) } } }
                GlassCard { VStack(spacing: 13) { SectionHeader(title: "海拔"); HStack { Text("18 m").font(.title2.bold()); Spacer(); Text("最高 42 m · 累计爬升 86 m").font(.caption).foregroundStyle(.secondary) }; Sparkline(values: [8,16,12,20,32,28,40,26,18], tint: .brown).frame(height: 70) } }
                HStack { exportButton("square.and.arrow.up", "分享图片"); exportButton("map", "导出 GPX"); exportButton("doc.richtext", "导出 PDF") }
            }.padding(18)
        }.navigationTitle("骑行详情").navigationBarTitleDisplayMode(.inline)
    }
    private func score(_ title: String, _ value: Int, _ tint: Color) -> some View { VStack(spacing: 5) { Text("\(value)").font(.title.bold()).foregroundStyle(tint); Text(title).font(.caption).foregroundStyle(.secondary) }.frame(maxWidth: .infinity).padding(.vertical, 16).background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18)) }
    private func exportButton(_ icon: String, _ title: String) -> some View { Button {} label: { VStack(spacing: 7) { Image(systemName: icon); Text(title).font(.caption2) }.frame(maxWidth: .infinity).padding(.vertical, 13).background(Color.accentColor.opacity(0.1), in: RoundedRectangle(cornerRadius: 16)) }.buttonStyle(.plain) }
}
