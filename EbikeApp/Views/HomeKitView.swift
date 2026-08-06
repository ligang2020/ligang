import SwiftUI

struct HomeKitView: View {
    @ObservedObject var model: AppViewModel
    @State private var alarm = false
    @State private var light = true
    @State private var charging = false
    var body: some View {
        NavigationStack {
            ScrollView { VStack(spacing: 22) { header; devices; automations; connectivity }.padding(.horizontal, 18).padding(.bottom, 120) }
                .scrollIndicators(.hidden).navigationTitle("HomeKit").navigationBarTitleDisplayMode(.large)
        }
    }
    private var header: some View { GlassCard { HStack(spacing: 16) { Image(systemName: "homekit").font(.system(size: 38)).foregroundStyle(.orange); VStack(alignment: .leading, spacing: 3) { Text("Aurora 家庭").font(.headline); Text("1 个家庭 · 3 个成员").font(.subheadline).foregroundStyle(.secondary) }; Spacer(); Image(systemName: "checkmark.circle.fill").foregroundStyle(.green) } } }
    private var devices: some View {
        VStack(spacing: 14) { SectionHeader(title: "设备")
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                homeTile("bicycle", "车辆", "在线", .blue) { model.perform("车辆状态正常") }
                homeToggle("lock.fill", "车锁", model.isLocked, .green) { model.isLocked.toggle() }
                homeToggle("lightbulb.fill", "车灯", light, .yellow) { light.toggle() }
                homeToggle("bell.fill", "报警器", alarm, .red) { alarm.toggle() }
                homeTile("rectangle.portrait.and.arrow.forward", "坐垫", "已关闭", .orange) { model.perform("坐垫已开启") }
                homeToggle("bolt.fill", "充电", charging, .green) { charging.toggle() }
            }
        }
    }
    private func homeTile(_ icon: String, _ title: String, _ state: String, _ tint: Color, _ action: @escaping () -> Void) -> some View { Button(action: action) { GlassCard(padding: 16) { VStack(alignment: .leading, spacing: 14) { Image(systemName: icon).font(.title2).foregroundStyle(tint); Text(title).font(.headline); Text(state).font(.caption).foregroundStyle(.secondary) }.frame(maxWidth: .infinity, alignment: .leading) } }.buttonStyle(.plain) }
    private func homeToggle(_ icon: String, _ title: String, _ isOn: Bool, _ tint: Color, _ action: @escaping () -> Void) -> some View { Button(action: action) { GlassCard(padding: 16) { VStack(alignment: .leading, spacing: 12) { HStack { Image(systemName: icon).font(.title2).foregroundStyle(tint); Spacer(); Circle().fill(isOn ? tint : Color.primary.opacity(0.12)).frame(width: 12, height: 12) }; Text(title).font(.headline); Text(isOn ? "已开启" : "已关闭").font(.caption).foregroundStyle(.secondary) }.frame(maxWidth: .infinity, alignment: .leading) } }.buttonStyle(.plain) }
    private var automations: some View { VStack(spacing: 14) { SectionHeader(title: "自动化", action: "添加") ; GlassCard { HStack { Image(systemName: "sunset.fill").font(.title2).foregroundStyle(.orange); VStack(alignment: .leading) { Text("离家时锁定车辆").font(.headline); Text("当最后一个人离开家时").font(.caption).foregroundStyle(.secondary) }; Spacer(); Toggle("", isOn: .constant(true)).labelsHidden() } } } }
    private var connectivity: some View { VStack(spacing: 14) { SectionHeader(title: "家庭连接") ; GlassCard { info("HomeKey", "可用", "key.fill", .blue); info("Matter", "已连接", "dot.radiowaves.left.and.right", .green); info("Thread", "已连接", "network", .orange); info("Home Hub", "Apple TV · 在线", "appletv.fill", .purple); info("Siri 快捷指令", "6 个可用", "waveform", .pink) } } }
    private func info(_ title: String, _ value: String, _ icon: String, _ tint: Color) -> some View { HStack { Image(systemName: icon).frame(width: 24).foregroundStyle(tint); Text(title); Spacer(); Text(value).font(.subheadline).foregroundStyle(.secondary); Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary) }.padding(.vertical, 9) }
}
