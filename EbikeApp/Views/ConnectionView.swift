import SwiftUI

struct ConnectionView: View {
    @EnvironmentObject private var connection: ConnectionViewModel
    @Environment(\.openURL) private var openURL
    @FocusState private var focusedField: Field?
    @State private var revealsToken = false

    private enum Field { case server, token }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        VehicleArtwork(compact: true)
                        Text("连接 Aurora").font(.largeTitle.bold())
                        Text("智能车辆服务").font(.subheadline).foregroundStyle(.secondary)
                    }.padding(.top, 24)

                    GlassCard {
                        VStack(spacing: 18) {
                            fieldLabel("server.rack", "服务器地址")
                            TextField("https://example.com", text: $connection.serverAddress)
                                .textContentType(.URL).keyboardType(.URL).textInputAutocapitalization(.never).autocorrectionDisabled()
                                .focused($focusedField, equals: .server)
                                .padding(14).background(Color.primary.opacity(0.055), in: RoundedRectangle(cornerRadius: 14))

                            fieldLabel("key.fill", "访问口令")
                            HStack {
                                Group {
                                    if revealsToken { TextField("App Bearer Token", text: $connection.accessToken) }
                                    else { SecureField("App Bearer Token", text: $connection.accessToken) }
                                }
                                .textContentType(.password).textInputAutocapitalization(.never).autocorrectionDisabled()
                                .focused($focusedField, equals: .token)
                                Button { revealsToken.toggle() } label: { Image(systemName: revealsToken ? "eye.slash.fill" : "eye.fill").foregroundStyle(.secondary) }.buttonStyle(.plain)
                            }.padding(14).background(Color.primary.opacity(0.055), in: RoundedRectangle(cornerRadius: 14))

                            if case let .failed(message) = connection.state {
                                Label(message, systemImage: "exclamationmark.triangle.fill")
                                    .font(.caption).foregroundStyle(.red).frame(maxWidth: .infinity, alignment: .leading)
                            }

                            Button {
                                focusedField = nil
                                Task { await connection.connect() }
                            } label: {
                                HStack(spacing: 8) {
                                    if connection.state == .connecting { ProgressView().tint(.white) }
                                    else { Image(systemName: "link") }
                                    Text(connection.state == .connecting ? "正在连接" : "连接服务器")
                                }.font(.headline).frame(maxWidth: .infinity).padding(.vertical, 14)
                            }
                            .buttonStyle(.borderedProminent).clipShape(RoundedRectangle(cornerRadius: 16)).disabled(connection.state == .connecting)
                        }
                    }

                    Button {
                        guard let url = URL(string: connection.serverAddress)?.appending(path: "admin/login") else { return }
                        openURL(url)
                    } label: { Label("管理后台", systemImage: "safari.fill").font(.subheadline.weight(.semibold)) }
                    .buttonStyle(.plain).foregroundStyle(.secondary)
                }.frame(maxWidth: 560).padding(.horizontal, 18).padding(.bottom, 36)
            }.scrollDismissesKeyboard(.interactively).background(Color(uiColor: .systemGroupedBackground)).toolbar(.hidden, for: .navigationBar)
        }
    }

    private func fieldLabel(_ icon: String, _ title: String) -> some View {
        Label(title, systemImage: icon).font(.subheadline.weight(.semibold)).frame(maxWidth: .infinity, alignment: .leading)
    }
}
