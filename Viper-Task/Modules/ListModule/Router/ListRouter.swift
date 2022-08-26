import UIKit
import XCoordinator

// MARK: - ListRoutes
enum ListRoutes: Route {
    case home
    case details(Int)
    case alert(String)
}

// MARK: - ListRouterInputProtocol
protocol ListRouterInputProtocol {
    var router: UnownedRouter<ListRoutes> { get set }
    init(router: UnownedRouter<ListRoutes>)
    
    func showDetail(with id: Int)
    func showError(message: String)
}

// MARK: - ListRouterInputProtocol Implementation
class ListRouter: ListRouterInputProtocol {
    var router: UnownedRouter<ListRoutes>
    
    required init(router: UnownedRouter<ListRoutes>) {
        self.router = router
    }
    
    func showDetail(with id: Int) {
        self.router.trigger(.details(id))
    }
    
    func showError(message: String) {
        self.router.trigger(.alert(message))
    }
}

// MARK: - ListCoordinator
class ListCoordinator: NavigationCoordinator<ListRoutes> {
    
    init() {
        super.init(initialRoute: .home)
    }
    
    override func prepareTransition(for route: ListRoutes) -> NavigationTransition {
        switch route {
        case .home:
            let module = ListAssembly.buildListModule(unownedRouter: unownedRouter)
            return .push(module)
        case .details(let id):
            let module = DetailsAssembly.buildDetailsModule(unownedRouter: unownedRouter, with: id)
            return .push(module)
        case .alert(let message):
            let alert = UIAlertController(title: Constants.Alerts.alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.Alerts.detailsAlertFirstAction, style: .default))
            return .present(alert)
        }
    }
}
