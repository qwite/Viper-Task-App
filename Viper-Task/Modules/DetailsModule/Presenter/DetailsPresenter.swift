import Foundation

// MARK: - DetailsPresenterProtocol
protocol DetailsPresenterProtocol {
    var view: DetailsViewProtocol? { get set }
    var interactor: DetailsInteractorInputProtocol? { get set }
    var router: DetailsRouterInputProtocol? { get set }
    
    var orderId: Int { get set }
    
    init(view: DetailsViewProtocol, interactor: DetailsInteractorInputProtocol, router: DetailsRouterInputProtocol, orderId: Int)
    func viewDidLoad()
}

// MARK: - DetailsPresenterProtocol Implementation
class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    var interactor: DetailsInteractorInputProtocol?
    var router: DetailsRouterInputProtocol?
    
    var orderId: Int
    
    required init(view: DetailsViewProtocol, interactor: DetailsInteractorInputProtocol, router: DetailsRouterInputProtocol, orderId: Int) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.orderId = orderId
    }
    
    func viewDidLoad() {
        self.view?.changeIndicatorState(state: true)
        self.interactor?.fetchDetailedOrder(by: orderId)
    }
}

// MARK: - DetailsInteractorOutputProtocol Implementation
extension DetailsPresenter: DetailsInteractorOutputProtocol {
    func configureView(viewModel: DetailedActiveOrderViewModel) {
        self.view?.configure(with: viewModel)
        self.view?.changeIndicatorState(state: false)
    }
    
    func showError(message: String) {
        self.router?.showError(message: message)
    }
}
