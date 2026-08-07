import SwiftUI

struct ProfileView: View {
    @ObservedObject var model: AppViewModel
    @EnvironmentObject private var connection: ConnectionViewModel
    @State private var showSettings = false
    @State private var showConnected = false
    var body: some View {
        NavigationStack {
            List {
                Section { profileHeader }.listRowBackground(Color.clear).listRowInsets(EdgeInsets(top: 12, leading: 18, bottom: 20, trailing: 18))
                Section("车辆与家庭") { row("bicycle", "车辆管理", "Aurora S1") { model.perform("车辆管理") }; row("person.2.fill", "家庭成员", "3 位成员") {} }
                Section("服务") { row("bell.badge.fill", "通知", "已开启") {}; row("lock.shield.fill", "隐私", "") {}; row("arrow.down.circle.fill", "OTA 升级", "已是最新") {}; row("waveform.path.ecg", "日志与诊断", "") {}; row("flask.fill", "实验室", "Beta") { showConnected = true } }
                Section("关于") { row("info.circle.fill", "关于 Aurora", "v1.0.0") {}; row("questionmark.circle.fill", "支持", "") {} }
                Section { Button(role: .destructive) { connection.disconnect() } label: { HStack { Spacer(); Text("退出登录"); Spacer() } } }.listRowBackground(Color.clear)
            }.listStyle(.insetGrouped).scrollContentBackground(.hidden).background(Color(uiColor: .systemGroupedBackground)).navigationTitle("我的").navigationBarTitleDisplayMode(.large)
                .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { showSettings = true } label: { Image(systemName: "gearshape.fill") } } }
                .sheet(isPresented: $showSettings) { SettingsView(model: model) }
                .sheet(isPresented: $showConnected) { ConnectedExperiencesView() }
        }
    }
    private var profileHeader: some View { HStack(spacing: 16) { ZStack { Circle().fill(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)); Text("L").font(.title.bold()).foregroundStyle(.white) }.frame(width: 64, height: 64); VStack(alignment: .leading, spacing: 4) { Text("Ligang").font(.title2.bold()); Text("Aurora 车主 · 上海").font(.subheadline).foregroundStyle(.secondary) }; Spacer(); Image(systemName: "chevron.right").foregroundStyle(.tertiary) } }
    private func row(_ icon: String, _ title: String, _ detail: String, _ action: @escaping () -> Void) -> some View { Button(action: action) { HStack { Image(systemName: icon).foregroundStyle(Color.accentColor).frame(width: 24); Text(title); Spacer(); if !detail.isEmpty { Text(detail).font(.subheadline).foregroundStyle(.secondary) }; Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary) } }.buttonStyle(.plain) }
}
