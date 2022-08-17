import Foundation

// MARK: - ActiveOrderViewModelType
protocol ActiveOrderViewModelType {
    var id: Int { get }
    var date: String { get }
    var startAddress: String { get }
    var endAddress: String { get }
    var price: String { get }
}

// MARK: - ActiveOrderViewModelType Implementation
struct ActiveOrderViewModel: ActiveOrderViewModelType {
    let id: Int
    let date: String
    let startAddress: String
    let endAddress: String
    let price: String
}
