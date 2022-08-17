import Foundation

// MARK: - DetailedActiveOrderViewModelType
protocol DetailedActiveOrderViewModelType {
    var common: ActiveOrderViewModelType { get }
    var image: Data { get }
    var vehicleRegNumber: String { get }
    var vehicleModelName: String { get }
    var vehiclePhoto: String { get }
    var vehicleDriverName: String { get }
}

// MARK: - DetailedActiveOrderViewModelType Implementation
struct DetailedActiveOrderViewModel: DetailedActiveOrderViewModelType {
    let common: ActiveOrderViewModelType
    let image: Data
    let vehicleRegNumber: String
    let vehicleModelName: String
    let vehiclePhoto: String
    let vehicleDriverName: String
}
