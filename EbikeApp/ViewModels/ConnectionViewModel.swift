import Foundation
import SwiftUI

@MainActor
final class ConnectionViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case connecting
        case connected(Int)
        case failed(String)
    }

    @Published var serverAddress: String
    @Published var accessToken: String
    @Published private(set) var state: State = .idle
    @Published private(set) var isConnected: Bool

    private let tokenKey = "appBearerToken"
    private let serverKey = "serverAddress"

    init() {
        let storedServer = UserDefaults.standard.string(forKey: serverKey)
        let bundledServer = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String
        serverAddress = storedServer ?? bundledServer ?? "https://9hao.ligangs2025.top:16689"

        let storedToken = KeychainStore.string(for: tokenKey)
        let bundledToken = Bundle.main.object(forInfoDictionaryKey: "APP_BEARER_TOKEN") as? String
        accessToken = storedToken ?? bundledToken ?? ""
        isConnected = storedToken?.isEmpty == false
    }

    func connect() async {
        let address = serverAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let token = accessToken.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let url = URL(string: address), let scheme = url.scheme, ["http", "https"].contains(scheme), !token.isEmpty else {
            state = .failed(token.isEmpty ? "请输入访问口令" : "服务器地址无效")
            return
        }

        state = .connecting
        do {
            let vehicles = try await APIClient(baseURL: url, bearerToken: token).vehicles()
            KeychainStore.set(token, for: tokenKey)
            UserDefaults.standard.set(address, forKey: serverKey)
            state = .connected(vehicles.count)
            withAnimation(Motion.state) { isConnected = true }
        } catch {
            state = .failed(error.localizedDescription)
        }
    }

    func disconnect() {
        KeychainStore.delete(tokenKey)
        accessToken = ""
        state = .idle
        withAnimation(Motion.transition) { isConnected = false }
    }
}
