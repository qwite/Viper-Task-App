import Foundation

// MARK: - ActiveOrder
struct ActiveOrder: Decodable {
    let id: Int
    let startAddress: Address
    let endAddress: Address
    let date: String
    let price: Price
    let vehicle: Vehicle
}

// MARK: CodingKeys
extension ActiveOrder {
    enum CodingKeys: String, CodingKey {
        case id
        case startAddress
        case endAddress
        case date = "orderTime"
        case price
        case vehicle
    }
}

// MARK: - Address
struct Address: Decodable {
    let city: String
    let address: String
}

// MARK: - Price
struct Price: Decodable {
    let amount: Int
    let currency: String
}

// MARK: - Vehicle
struct Vehicle: Decodable {
    let regNumber: String
    let modelName: String
    let photo: String
    let driverName: String
}
