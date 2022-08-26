import Foundation

// MARK: - DetailedActiveOrderViewModel
struct DetailedActiveOrderViewModel {
    let common: ActiveOrderViewModel
    let image: Data
    let vehicleModelWithRegNumber: String
    let vehiclePhoto: String
    let vehicleDriverName: String
    
    init(common: ActiveOrderViewModel, image: Data, vehicleModelName: String, vehicleRegNumber: String, vehiclePhoto: String, vehicleDriverName: String) {
        self.common = common
        self.image = image
        self.vehicleModelWithRegNumber = "\(vehicleModelName) / \(vehicleRegNumber)"
        self.vehiclePhoto = vehiclePhoto
        self.vehicleDriverName = vehicleDriverName
    }
}
