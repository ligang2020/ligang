import Foundation

struct Vehicle {
    let name: String
    let model: String
    let battery: Int
    let range: Int
    let mileage: Int
    let speed: Double
    let voltage: Double
    let current: Double
    let power: Int
    let temperature: Double
    let controllerTemperature: Double
    let batteryTemperature: Double
    let soc: Int
    let soh: Int
    let isCharging: Bool
    let isLocked: Bool
    let vin: String
    let firmware: String
}

struct Ride: Identifiable {
    let id = UUID()
    let day: String
    let start: String
    let end: String
    let duration: String
    let distance: String
    let averageSpeed: String
    let maxSpeed: String
    let energy: String
    let color: String
}

extension Vehicle {
    static let demo = Vehicle(
        name: "Aurora S1", model: "Performance Edition", battery: 86,
        range: 68, mileage: 2486, speed: 0, voltage: 52.4, current: 0,
        power: 0, temperature: 24.8, controllerTemperature: 28.1,
        batteryTemperature: 25.2, soc: 86, soh: 98, isCharging: false,
        isLocked: true, vin: "LS6AURORA••••4821", firmware: "v3.4.1"
    )
}

extension Ride {
    static let demo: [Ride] = [
        Ride(day: "今天", start: "08:42", end: "09:18", duration: "36 分钟", distance: "12.8 km", averageSpeed: "21.3 km/h", maxSpeed: "38.7 km/h", energy: "8%", color: "0A84FF"),
        Ride(day: "昨天", start: "18:06", end: "18:51", duration: "45 分钟", distance: "16.4 km", averageSpeed: "22.1 km/h", maxSpeed: "41.2 km/h", energy: "11%", color: "34C759"),
        Ride(day: "周一", start: "07:55", end: "08:24", duration: "29 分钟", distance: "9.6 km", averageSpeed: "19.8 km/h", maxSpeed: "34.5 km/h", energy: "7%", color: "FF9F0A")
    ]
}
