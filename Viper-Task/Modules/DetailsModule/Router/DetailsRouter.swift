import Foundation
import UIKit
import XCoordinator

enum DetailsRoute: Route {
    case alert(String)
}

// MARK: - DetailsRouterInput
protocol DetailsRouterInputProtocol: AnyObject {
    var router: UnownedRouter<ListRoutes> { get set }
    init(router: UnownedRouter<ListRoutes>)
    
    func showError(message: String)
}

// MARK: - DetailsRouterInputProtocol Implementation
class DetailsRouter: DetailsRouterInputProtocol {
    var router: UnownedRouter<ListRoutes>
    
    required init(router: UnownedRouter<ListRoutes>) {
        self.router = router
    }
    
    func showError(message: String) {
        router.trigger(.alert(message))
    }
}
