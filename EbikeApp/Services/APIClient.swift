import Foundation

actor APIClient {
    static let shared = APIClient()

    func get(path: String) async throws -> Data {
        var request = APIConfig.request(path: path)
        request.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
