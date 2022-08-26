import Foundation

// MARK: - ActiveOrderMapper
class ActiveOrderMapper {
    enum DateType {
        case date
        case dateWithTime
    }
    
    static func convert(from order: ActiveOrder, dateType: DateType) -> ActiveOrderViewModel {
        var date: String?
        switch dateType {
        case .date:
            date = DateFormatter.getFullDate(date: order.date)
        case .dateWithTime:
            date = DateFormatter.getFullDateTime(date: order.date)
        }
        
        let convertedPrice = String(format: "%.2f", Double(order.price.amount) / 100.00)
        
        return ActiveOrderViewModel(id: order.id,
                                    date: date ?? "nil",
                                    startAddress: order.startAddress.address,
                                    endAddress: order.endAddress.address,
                                    price: convertedPrice)
    }
    
    static func convert(from activeOrders: [ActiveOrder]) -> [ActiveOrderViewModel] {
        var array: [ActiveOrderViewModel] = []
        
        for order in activeOrders {
            array.append(convert(from: order, dateType: .date))
        }
        
        return array
    }
    
    static func convertDetail(from order: ActiveOrder, image: Data) -> DetailedActiveOrderViewModel {
        let commonViewModel = convert(from: order, dateType: .dateWithTime)
        let detailViewModel = DetailedActiveOrderViewModel(common: commonViewModel,
                                                           image: image,
                                                           vehicleModelName: order.vehicle.modelName,
                                                           vehicleRegNumber: order.vehicle.regNumber,
                                                           vehiclePhoto: order.vehicle.photo,
                                                           vehicleDriverName: order.vehicle.driverName)
        return detailViewModel
    }
}
