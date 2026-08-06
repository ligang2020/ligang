import SwiftUI

struct ConnectedExperiencesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("实时状态") {
                    NavigationLink { LiveActivityGallery() } label: { experience("waveform.path.ecg.rectangle", "Live Activity", "锁车、充电与骑行") }
                    NavigationLink { LiveActivityGallery() } label: { experience("dynamic.island", "Dynamic Island", "紧凑与展开状态") }
                }
                Section("桌面") { NavigationLink { WidgetGallery() } label: { experience("rectangle.grid.2x2.fill", "Widget", "Small、Medium、Large、锁屏") } }
                Section("随身设备") { NavigationLink { WatchGallery() } label: { experience("applewatch", "Apple Watch", "车锁、寻车、电量与 Siri") }; experience("carplay", "CarPlay", "驾驶模式") }
            }.navigationTitle("设备体验").navigationBarTitleDisplayMode(.inline)
        }
    }
    private func experience(_ icon: String, _ title: String, _ detail: String) -> some View { HStack(spacing: 14) { Image(systemName: icon).font(.title3).foregroundStyle(.blue).frame(width: 28); VStack(alignment: .leading, spacing: 2) { Text(title); Text(detail).font(.caption).foregroundStyle(.secondary) }; Spacer() } }
}

private struct LiveActivityGallery: View {
    @State private var mode = "骑行"
    let modes = ["锁车", "充电", "骑行"]
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Picker("状态", selection: $mode) { ForEach(modes, id: \.self) { Text($0) } }.pickerStyle(.segmented)
                VStack(spacing: 8) {
                    Text("Dynamic Island").font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 12) {
                        Image(systemName: mode == "充电" ? "bolt.fill" : mode == "锁车" ? "lock.fill" : "figure.outdoor.cycle").foregroundStyle(mode == "充电" ? Color.green : Color.blue)
                        Text("Aurora").font(.caption.bold()); Spacer()
                        Text(mode == "骑行" ? "24 km/h" : mode == "充电" ? "86%" : "已锁定").font(.caption.bold().monospacedDigit())
                    }.padding(.horizontal, 16).frame(height: 38).background(Color.black, in: Capsule()).foregroundStyle(.white)
                }
                liveCard
                VStack(alignment: .leading, spacing: 12) { Text("锁定屏幕").font(.headline); liveCard }.padding(18).background(LinearGradient(colors: [.indigo.opacity(0.6), .black], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 28))
            }.padding(18)
        }.navigationTitle("实时活动").navigationBarTitleDisplayMode(.inline)
    }
    private var liveCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack { Label("AURORA", systemImage: "bicycle").font(.caption.bold()); Spacer(); Text(mode == "骑行" ? "骑行中" : mode == "充电" ? "正在充电" : "车辆安全").font(.caption).foregroundStyle(.secondary) }
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 2) { Text(mode == "骑行" ? "24" : mode == "充电" ? "86" : "68").font(.system(size: 38, weight: .bold, design: .rounded)); Text(mode == "骑行" ? "km/h" : mode == "充电" ? "% 电量" : "km 剩余续航").font(.caption).foregroundStyle(.secondary) }
                Spacer(); Image(systemName: mode == "锁车" ? "lock.shield.fill" : mode == "充电" ? "battery.75percent" : "location.north.line.fill").font(.system(size: 32)).foregroundStyle(mode == "充电" ? Color.green : Color.blue)
            }
            ProgressView(value: mode == "充电" ? 0.86 : 0.62).tint(mode == "充电" ? .green : .blue)
            HStack { Text(mode == "充电" ? "预计 42 分钟充满" : "徐汇滨江 · 12.8 km"); Spacer(); Text("52.4 V") }.font(.caption).foregroundStyle(.secondary)
        }.padding(18).background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous)).overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(.white.opacity(0.12)))
    }
}

private struct WidgetGallery: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Small").font(.headline); small.frame(width: 170, height: 170)
                Text("Medium").font(.headline); medium.frame(height: 170)
                Text("Large").font(.headline); large.frame(height: 330)
                Text("Lock Screen").font(.headline); HStack { lockWidget("lock.fill", "已锁定"); lockWidget("battery.75percent", "86% · 68 km"); lockWidget("location.fill", "128 m") }
            }.padding(18)
        }.navigationTitle("Widget").navigationBarTitleDisplayMode(.inline)
    }
    private var small: some View { widgetSurface { VStack(alignment: .leading) { HStack { Image(systemName: "bicycle").foregroundStyle(.blue); Spacer(); Image(systemName: "lock.fill").foregroundStyle(.green) }; Spacer(); Text("86%").font(.system(size: 36, weight: .bold, design: .rounded)); Text("68 km 续航").font(.caption).foregroundStyle(.secondary) } } }
    private var medium: some View { widgetSurface { HStack { BatteryRing(value: 0.86, size: 105, lineWidth: 9); VStack(alignment: .leading, spacing: 10) { Text("Aurora S1").font(.headline); Label("已锁定", systemImage: "lock.fill").foregroundStyle(.green); Label("徐汇滨江", systemImage: "location.fill").font(.caption).foregroundStyle(.secondary) }; Spacer() } } }
    private var large: some View { widgetSurface { VStack(alignment: .leading, spacing: 16) { HStack { Text("Aurora S1").font(.title3.bold()); Spacer(); Label("在线", systemImage: "circle.fill").font(.caption).foregroundStyle(.green) }; VehicleArtwork(compact: true); HStack { metric("86%", "电量"); metric("68 km", "续航"); metric("已锁定", "状态") }; HStack { widgetAction("lock.open.fill", "解锁"); widgetAction("location.viewfinder", "寻车"); widgetAction("lightbulb.fill", "车灯") } } } }
    private func widgetSurface<Content: View>(@ViewBuilder _ content: () -> Content) -> some View { content().padding(18).frame(maxWidth: .infinity, maxHeight: .infinity).background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24)).overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(Color.primary.opacity(0.08))) }
    private func metric(_ value: String, _ title: String) -> some View { VStack(alignment: .leading) { Text(value).font(.headline); Text(title).font(.caption).foregroundStyle(.secondary) }.frame(maxWidth: .infinity, alignment: .leading) }
    private func widgetAction(_ icon: String, _ title: String) -> some View { VStack { Image(systemName: icon); Text(title).font(.caption2) }.frame(maxWidth: .infinity).padding(.vertical, 10).background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 13)) }
    private func lockWidget(_ icon: String, _ value: String) -> some View { VStack(spacing: 7) { Image(systemName: icon).font(.title3); Text(value).font(.caption2.bold()) }.frame(maxWidth: .infinity).frame(height: 74).background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18)) }
}

private struct WatchGallery: View {
    @State private var locked = true
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ZStack {
                    RoundedRectangle(cornerRadius: 48, style: .continuous).fill(Color.black).frame(width: 220, height: 270).shadow(radius: 20)
                    VStack(spacing: 16) {
                        HStack { Text("Aurora").font(.caption.bold()); Spacer(); Text("86%").font(.caption).foregroundStyle(.green) }
                        Image(systemName: locked ? "lock.fill" : "lock.open.fill").font(.system(size: 36)).foregroundStyle(.blue)
                        Text(locked ? "车辆已锁定" : "车辆已解锁").font(.headline)
                        HStack { watchButton("location.viewfinder", "寻车"); watchButton("waveform", "Siri") }
                    }.foregroundStyle(.white).frame(width: 176)
                }
                Button { withAnimation(Motion.state) { locked.toggle() } } label: { Label(locked ? "解锁车辆" : "锁定车辆", systemImage: locked ? "lock.open.fill" : "lock.fill").frame(maxWidth: .infinity) }.buttonStyle(.borderedProminent).controlSize(.large)
                GlassCard { HStack { BatteryRing(value: 0.86, size: 92, lineWidth: 8); VStack(alignment: .leading, spacing: 5) { Text("剩余续航").font(.caption).foregroundStyle(.secondary); Text("68 km").font(.title2.bold()); Text("最后同步：刚刚").font(.caption2).foregroundStyle(.secondary) }; Spacer() } }
            }.padding(18)
        }.navigationTitle("Apple Watch").navigationBarTitleDisplayMode(.inline)
    }
    private func watchButton(_ icon: String, _ title: String) -> some View { VStack(spacing: 5) { Image(systemName: icon); Text(title).font(.caption2) }.frame(width: 70, height: 52).background(.white.opacity(0.14), in: RoundedRectangle(cornerRadius: 14)) }
}
