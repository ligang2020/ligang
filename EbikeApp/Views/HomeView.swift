import SwiftUI

struct HomeView: View {
    @ObservedObject var model: AppViewModel
    @State private var batteryExpanded = false
    private let metrics = [
        ("speedometer", "速度", "0.0", "km/h", Color.blue), ("bolt.horizontal.fill", "电压", "52.4", "V", Color.orange),
        ("waveform.path.ecg", "电流", "0.0", "A", Color.green), ("bolt.fill", "功率", "0", "W", Color.yellow),
        ("thermometer.medium", "环境温度", "24.8", "°C", Color.cyan), ("cpu", "控制器", "28.1", "°C", Color.purple),
        ("battery.75percent", "电池温度", "25.2", "°C", Color.mint), ("heart.fill", "SOH", "98", "%", Color.red)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    hero
                    controls
                    status
                    battery
                    vehicleInfo
                }.padding(.horizontal, 18).padding(.bottom, 120)
            }.scrollIndicators(.hidden).navigationTitle("我的车辆").navigationBarTitleDisplayMode(.large)
                .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { model.perform("车辆数据已刷新") } label: { Image(systemName: "arrow.clockwise") } } }
        }
    }

    private var hero: some View {
        VStack(spacing: 8) {
            VehicleArtwork()
            Text(model.vehicle.name).font(.title.weight(.bold))
            Text(model.vehicle.model).font(.subheadline).foregroundStyle(.secondary)
            HStack(spacing: 8) {
                StatusPill(icon: "dot.radiowaves.left.and.right", title: "车辆", value: "在线")
                StatusPill(icon: "bluetooth", title: "蓝牙", value: "已连接", tint: .blue)
                StatusPill(icon: "homekit", title: "家庭", value: "已加入", tint: .orange)
            }.padding(.top, 6)
            HStack(spacing: 0) {
                heroMetric("\(model.vehicle.battery)%", "电量")
                Divider().frame(height: 34)
                heroMetric("\(model.vehicle.range) km", "当前续航")
                Divider().frame(height: 34)
                heroMetric("2,486 km", "总里程")
            }.padding(.vertical, 15)
            Label("上海市 · 徐汇滨江", systemImage: "location.fill").font(.caption).foregroundStyle(.secondary)
        }.frame(maxWidth: .infinity)
    }

    private func heroMetric(_ value: String, _ label: String) -> some View {
        VStack(spacing: 3) { Text(value).font(.headline.monospacedDigit()); Text(label).font(.caption).foregroundStyle(.secondary) }.frame(maxWidth: .infinity)
    }

    private var controls: some View {
        GlassCard {
            VStack(spacing: 16) {
                SectionHeader(title: "快捷控制")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 10)], spacing: 10) {
                    ActionTile(icon: model.isLocked ? "lock.open.fill" : "lock.fill", title: model.isLocked ? "一键解锁" : "一键上锁", tint: .blue) { model.isLocked.toggle(); model.perform(model.isLocked ? "车辆已上锁" : "车辆已解锁") }
                    ActionTile(icon: "rectangle.portrait.and.arrow.forward", title: "开启坐垫", tint: .orange) { model.perform("坐垫已开启") }
                    ActionTile(icon: "location.viewfinder", title: "寻找车辆", tint: .green) { model.perform("车辆正在响铃闪灯") }
                    ActionTile(icon: "bell.and.waves.left.and.right.fill", title: "开启警报", tint: .red) { model.perform("警报已开启") }
                    ActionTile(icon: "wave.3.right.circle.fill", title: "NFC", tint: .purple) { model.perform("NFC 钥匙已就绪") }
                    ActionTile(icon: "lightbulb.fill", title: "车灯", tint: .yellow) { model.perform("车灯已开启") }
                }
            }
        }
    }

    private var status: some View {
        VStack(spacing: 14) {
            SectionHeader(title: "实时车辆状态", action: "在线")
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 145), spacing: 12)], spacing: 12) {
                ForEach(metrics, id: \.1) { MetricCard(icon: $0.0, title: $0.1, value: $0.2, unit: $0.3, tint: $0.4) }
                MetricCard(icon: "battery.100percent.bolt", title: "充电状态", value: "未充电", unit: "", tint: .green)
                MetricCard(icon: "gauge.with.dots.needle.67percent", title: "SOC", value: "86", unit: "%", tint: .blue)
            }
        }
    }

    private var battery: some View {
        GlassCard {
            VStack(spacing: 20) {
                SectionHeader(title: "电池", action: batteryExpanded ? "收起" : "20 串详情") { withAnimation(.spring(response: 0.38, dampingFraction: 0.9)) { batteryExpanded.toggle() } }
                HStack(spacing: 26) {
                    BatteryRing(value: 0.86, size: 132, lineWidth: 12)
                    VStack(alignment: .leading, spacing: 14) {
                        batteryRow("预计续航", "68 km")
                        batteryRow("健康度", "98%")
                        batteryRow("循环次数", "128 次")
                        batteryRow("充电次数", "164 次")
                    }.frame(maxWidth: .infinity)
                }
                Divider()
                HStack { batteryRow("电池温度", "25.2°C"); Spacer(); batteryRow("总电压", "52.4 V") }
                if batteryExpanded { cellVoltages.transition(.opacity.combined(with: .move(edge: .top))) }
            }
        }
    }

    private func batteryRow(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) { Text(title).font(.caption).foregroundStyle(.secondary); Text(value).font(.headline.monospacedDigit()) }
    }

    private var cellVoltages: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("单串电压").font(.subheadline.weight(.semibold))
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 74), spacing: 8)], spacing: 8) {
                ForEach(1...20, id: \.self) { i in Text("\(i)  \(String(format: "%.3f", 3.279 + Double(i % 4) * 0.002)) V").font(.caption2.monospacedDigit()).padding(.vertical, 8).frame(maxWidth: .infinity).background(Color.green.opacity(0.1), in: RoundedRectangle(cornerRadius: 9)) }
            }
        }
    }

    private var vehicleInfo: some View {
        GlassCard {
            VStack(spacing: 14) {
                SectionHeader(title: "车辆信息")
                infoRow("VIN", model.vehicle.vin); infoRow("固件版本", "v3.4.1"); infoRow("BLE 版本", "2.8.0"); infoRow("控制器版本", "C.12.7"); infoRow("仪表版本", "D.6.2"); infoRow("OTA 状态", "已是最新版本", tint: .green)
            }
        }
    }

    private func infoRow(_ title: String, _ value: String, tint: Color = .secondary) -> some View { HStack { Text(title).foregroundStyle(.secondary); Spacer(); Text(value).font(.subheadline.weight(.medium)).foregroundStyle(tint) } }
}
