import Foundation

// MARK: - ListInteractorInputProtocol
protocol ListInteractorInputProtocol {
    var presenter: ListInteractorOutputProtocol? { get set }
    var service: NetworkServiceProtocol? { get set }
    
    init(service: NetworkServiceProtocol)
    
    func fetchOrders()
}

// MARK: - ListInteractorOutputProtocol Implementation
protocol ListInteractorOutputProtocol: AnyObject {
    func setViewModel(viewModel: [ActiveOrderViewModel])
    func showError(message: String)
}

// MARK: - ListInteractorInputProtocol Implementation
class ListInteractor: ListInteractorInputProtocol {
    var service: NetworkServiceProtocol?
    weak var presenter: ListInteractorOutputProtocol?
    
    required init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func fetchOrders() {
        service?.fetchActiveOrders(completion: { result in
            switch result {
            case .success(let orders):
                let viewModel = ActiveOrderMapper.convert(from: orders)
                self.presenter?.setViewModel(viewModel: viewModel)
            case .failure(let error):
                self.presenter?.showError(message: Constants.Errors.loadingOrdersError + ": \(error)")
            }
        })
    }
}
