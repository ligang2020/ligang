import Foundation

struct BackendVehicle: Decodable, Identifiable {
    let sn: String
    let name: String?
    let model: String?
    let imageURL: String?

    var id: String { sn }

    enum CodingKeys: String, CodingKey {
        case sn, name, model
        case imageURL = "image_url"
    }
}

struct AccountLoginRequest: Encodable {
    let account: String
    let password: String
    let areaCode: String?

    enum CodingKeys: String, CodingKey {
        case account, password
        case areaCode = "area_code"
    }
}

enum BackendError: LocalizedError {
    case invalidServer
    case invalidResponse
    case http(Int, String)

    var errorDescription: String? {
        switch self {
        case .invalidServer: "服务器地址无效"
        case .invalidResponse: "服务器响应无法识别"
        case let .http(status, message): message.isEmpty ? "连接失败（\(status)）" : message
        }
    }
}
