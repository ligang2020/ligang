import SwiftUI

struct SettingsView: View {
    @ObservedObject var model: AppViewModel
    @EnvironmentObject private var connection: ConnectionViewModel
    @AppStorage("darkMode") private var darkMode = false
    @AppStorage("autoUpdate") private var autoUpdate = true
    @State private var faceID = true
    @State private var notifications = true
    @State private var location = true
    @State private var bluetooth = true
    var body: some View {
        NavigationStack { List {
            Section("安全") { settingToggle("faceid", "Face ID 解锁", $faceID); settingToggle("bell.fill", "通知", $notifications); settingToggle("location.fill", "定位服务", $location); settingToggle("bluetooth", "蓝牙", $bluetooth) }
            Section("智能体验") { settingRow("waveform", "Siri 与快捷指令", "已配置") {}; settingRow("rectangle.grid.2x2.fill", "Widget", "3 个") {}; settingRow("bolt.horizontal.circle.fill", "Live Activity", "已开启") {}; settingRow("applewatch", "Apple Watch", "已连接") {}; settingRow("car.fill", "CarPlay", "已允许") {}; settingRow("homekit", "HomeKit", "已连接") }
            Section("偏好") { settingToggle("arrow.down.circle.fill", "自动更新", $autoUpdate); settingToggle("moon.fill", "深色模式", $darkMode); settingRow("globe", "语言", "简体中文") {}; settingRow("ruler", "单位", "公制") {} }
            Section("开发者") {
                NavigationLink { ConnectionView() } label: { HStack { Image(systemName: "server.rack").foregroundStyle(.blue).frame(width: 24); Text("接口连接"); Spacer(); Text(connection.serverAddress.replacingOccurrences(of: "https://", with: "")).font(.caption).foregroundStyle(.secondary).lineLimit(1) } }
                settingRow("key.fill", "App Bearer Token", "已安全存储") {}
            }
        }.listStyle(.insetGrouped).navigationTitle("设置").navigationBarTitleDisplayMode(.inline).preferredColorScheme(darkMode ? .dark : nil) }
    }
    private func settingToggle(_ icon: String, _ title: String, _ value: Binding<Bool>) -> some View { HStack { Image(systemName: icon).foregroundStyle(.blue).frame(width: 24); Text(title); Spacer(); Toggle("", isOn: value).labelsHidden() } }
    private func settingRow(_ icon: String, _ title: String, _ detail: String, _ action: @escaping () -> Void = {}) -> some View { Button(action: action) { HStack { Image(systemName: icon).foregroundStyle(.blue).frame(width: 24); Text(title); Spacer(); Text(detail).font(.subheadline).foregroundStyle(.secondary); Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary) } }.buttonStyle(.plain) }
}
