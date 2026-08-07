import Foundation

struct APIClient {
    let baseURL: URL
    let bearerToken: String

    func vehicles() async throws -> [BackendVehicle] {
        let data = try await send(path: "vehicles")
        return try JSONDecoder().decode([BackendVehicle].self, from: data)
    }

    func accountLogin(account: String, password: String, areaCode: String = "86") async throws -> Data {
        var request = authorizedRequest(path: "accounts/login")
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(AccountLoginRequest(account: account, password: password, areaCode: areaCode))
        return try await execute(request)
    }

    private func send(path: String) async throws -> Data {
        try await execute(authorizedRequest(path: path))
    }

    private func authorizedRequest(path: String) -> URLRequest {
        var request = URLRequest(url: baseURL.appending(path: path))
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 15
        return request
    }

    private func execute(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse else { throw BackendError.invalidResponse }
        guard 200..<300 ~= http.statusCode else {
            let detail = (try? JSONSerialization.jsonObject(with: data) as? [String: Any])?["detail"] as? String ?? ""
            throw BackendError.http(http.statusCode, detail)
        }
        return data
    }
}
