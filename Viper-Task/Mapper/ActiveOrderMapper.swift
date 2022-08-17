import Foundation

// MARK: - ActiveOrderMapper
class ActiveOrderMapper {
    enum DateType {
        case date
        case dateWithTime
    }
    
    static func convert(from order: ActiveOrder, dateType: DateType) -> ActiveOrderViewModelType {
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
    
    static func convert(from activeOrders: [ActiveOrder]) -> [ActiveOrderViewModelType] {
        var array: [ActiveOrderViewModelType] = []
        
        for order in activeOrders {
            array.append(convert(from: order, dateType: .date))
        }
        
        return array
    }
    
    static func convertDetail(from order: ActiveOrder, image: Data) -> DetailedActiveOrderViewModelType {
        let commonViewModel = convert(from: order, dateType: .dateWithTime)
        let detailViewModel = DetailedActiveOrderViewModel(common: commonViewModel,
                                                           image: image,
                                                           vehicleRegNumber: order.vehicle.regNumber,
                                                           vehicleModelName: order.vehicle.modelName,
                                                           vehiclePhoto: order.vehicle.photo,
                                                           vehicleDriverName: order.vehicle.driverName)
        return detailViewModel
    }
}
