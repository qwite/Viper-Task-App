import Foundation

// MARK: - ActiveOrderViewModel
struct ActiveOrderViewModel {
    let id: Int
    let date: String
    let startAddress: String
    let endAddress: String
    let price: String
    
    init(id: Int, date: String, startAddress: String, endAddress: String, price: String) {
        self.id = id
        self.date = date
        self.startAddress = startAddress
        self.endAddress = endAddress
        self.price = "\(price) ₽"
    }
}
