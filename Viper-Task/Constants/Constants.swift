import Foundation
import UIKit

// MARK: Constants
enum Constants {
    // Headers
    enum Headers {
        static let listTableViewHeader = "Активные заказы"
       
        static let dateAddressTitle = "Дата поездки"
        static let dateTimeAddressTitle = "Дата и время поездки"
        static let startAddressTitle = "Начальный адрес"
        static let endAddressTitle = "Конечный адрес"
        static let priceAddressTitle = "Стоимость заказа"
        static let carAddressTitle = "Машина"
        static let driverAddressTitle = "Водитель"
    }
    
    // Endpoints
    enum Endpoints {
        static let orders = "https://www.roxiemobile.ru/careers/test/orders.json"
        static let images = "https://www.roxiemobile.ru/careers/test/images/"
    }
    
    // Fonts
    enum Fonts {
        static let titleItemFont: UIFont = .systemFont(ofSize: 11, weight: .regular)
        static let detailedTitleItemFont: UIFont = .systemFont(ofSize: 13, weight: .heavy)
        static let descriptionItemFont: UIFont = .systemFont(ofSize: 13, weight: .thin)
    }
    
    // Alerts
    enum Alerts {
        static let alertTitle = "Произошла ошибка"
        static let detailsAlertFirstAction = "OK"
    }
    
    // Errors
    enum Errors {
        static let downloadingImageError = "Произошла ошибка при загрузке изображения"
        static let loadingOrdersError = "Произошла ошибка при загрузке заказов"
    }
}
