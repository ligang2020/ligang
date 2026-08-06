import SwiftUI

struct RideView: View {
    @ObservedObject var model: AppViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    summary
                    VStack(spacing: 14) {
                        SectionHeader(title: "骑行记录", action: "全部")
                        ForEach(model.rides) { ride in
                            NavigationLink { RideDetailView(ride: ride) } label: { RidePass(ride: ride) }.buttonStyle(.plain)
                        }
                    }
                }.padding(.horizontal, 18).padding(.bottom, 120)
            }.scrollIndicators(.hidden).navigationTitle("骑行").navigationBarTitleDisplayMode(.large)
        }
    }
    private var summary: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 20) {
                HStack { VStack(alignment: .leading) { Text("今日骑行").font(.headline); Text("12.8").font(.system(size: 52, weight: .bold, design: .rounded)); Text("公里").font(.subheadline).foregroundStyle(.secondary) }; Spacer(); BatteryRing(value: 0.72, size: 94, lineWidth: 9, label: "目标") }
                HStack { summaryItem("36", "分钟", "今日时间"); summaryItem("8", "%", "今日耗电"); summaryItem("312", "kcal", "消耗") }
                Sparkline(values: [10, 14, 8, 22, 31, 28, 36, 25, 40, 34, 47], tint: .green).frame(height: 52)
            }
        }
    }
    private func summaryItem(_ value: String, _ unit: String, _ label: String) -> some View { VStack(alignment: .leading, spacing: 3) { HStack(alignment: .firstTextBaseline, spacing: 2) { Text(value).font(.title3.bold()); Text(unit).font(.caption).foregroundStyle(.secondary) }; Text(label).font(.caption).foregroundStyle(.secondary) }.frame(maxWidth: .infinity, alignment: .leading) }
}

private struct RidePass: View {
    let ride: Ride
    var body: some View {
        VStack(spacing: 0) {
            MockMap().frame(height: 118).clipShape(UnevenRoundedRectangle(topLeadingRadius: 22, topTrailingRadius: 22))
            VStack(alignment: .leading, spacing: 14) {
                HStack { VStack(alignment: .leading, spacing: 2) { Text(ride.day).font(.headline); Text("\(ride.start) – \(ride.end)").font(.caption).foregroundStyle(.secondary) }; Spacer(); Text(ride.distance).font(.title3.bold()) }
                HStack { mini("时长", ride.duration); mini("均速", ride.averageSpeed); mini("耗电", ride.energy) }
            }.padding(16).background(.regularMaterial)
        }.clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous)).overlay(RoundedRectangle(cornerRadius: 22).strokeBorder(Color.primary.opacity(0.06))).shadow(color: .black.opacity(0.06), radius: 14, y: 7)
    }
    private func mini(_ title: String, _ value: String) -> some View { VStack(alignment: .leading, spacing: 2) { Text(title).font(.caption2).foregroundStyle(.secondary); Text(value).font(.caption.weight(.semibold)) }.frame(maxWidth: .infinity, alignment: .leading) }
}
