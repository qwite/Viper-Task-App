import UIKit
import XCoordinator

// MARK: - ListAssembly
class ListAssembly {
    static func buildListModule(unownedRouter: UnownedRouter<ListRoutes>) -> UIViewController {
        let view = ListViewController()
        let service = NetworkService()
        let interactor = ListInteractor(service: service)
        let router = ListRouter(router: unownedRouter)
        
        let presenter = ListPresenter(view: view, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
    }
}
