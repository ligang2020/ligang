import Foundation

enum APIConfig {
    static let baseURL: URL = {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
              let url = URL(string: value), !value.isEmpty else {
            preconditionFailure("API_BASE_URL is missing from build configuration")
        }
        return url
    }()

    static let bearerToken: String = {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "APP_BEARER_TOKEN") as? String,
              !token.isEmpty else { return "" }
        return token
    }()

    static func request(path: String) -> URLRequest {
        var request = URLRequest(url: baseURL.appending(path: path))
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
