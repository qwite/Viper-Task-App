import UIKit
import XCoordinator

// MARK: - DetailsAssembly
class DetailsAssembly {
    static func buildDetailsModule(unownedRouter: UnownedRouter<ListRoutes>, with id: Int) -> UIViewController {
        let view = DetailsViewController()
        let service = NetworkService()
        let fileService = FileService()
        let interactor = DetailsInteractor(service: service, fileService: fileService)
        let router = DetailsRouter(router: unownedRouter)
        let presenter = DetailsPresenter(view: view, interactor: interactor, router: router, orderId: id)
        
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
