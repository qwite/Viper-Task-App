import Foundation
import XCoordinator

// MARK: - ListPresenterProtocol
protocol ListPresenterProtocol {
    var view: ListViewProtocol? { get set }
    var interactor: ListInteractorInputProtocol? { get set }
    var router: ListRouterInputProtocol? { get set }

    init(view: ListViewProtocol, interactor: ListInteractorInputProtocol, router: ListRouterInputProtocol)
    func viewDidLoad()
    
    func fetchActiveOrders()
    func getViewModelCount() -> Int
    func getItemViewModel(at row: Int) -> ActiveOrderViewModelType?
    func didItemSelected(at row: Int)
}

// MARK: - ListPresenterProtocol Implementation
class ListPresenter: ListPresenterProtocol {
    weak var view: ListViewProtocol?
    var interactor: ListInteractorInputProtocol?
    private var viewModel: [ActiveOrderViewModelType] = [] {
        didSet {
            view?.updateTableView()
        }
    }
    
    var router: ListRouterInputProtocol?
    
    required init(view: ListViewProtocol, interactor: ListInteractorInputProtocol, router: ListRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.configureTableView()
        
        fetchActiveOrders()
    }
    
    func didItemSelected(at row: Int) {
        let orderId = viewModel[row].id
        router?.showDetail(with: orderId)
    }
    
    func fetchActiveOrders() {
        view?.changeIndicatorState(state: true)
        interactor?.fetchOrders()
    }
        
    func getViewModelCount() -> Int {
        return viewModel.count
    }
    
    func getItemViewModel(at row: Int) -> ActiveOrderViewModelType? {
        return viewModel[row]
    }
}

// MARK: - ListInteractorOutputProtocol Implementation
extension ListPresenter: ListInteractorOutputProtocol {
    func showError(message: String) {
        router?.showError(message: message)
    }
    
    func setViewModel(viewModel: [ActiveOrderViewModelType]) {
        let sortedViewModel = viewModel.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        
        self.viewModel = sortedViewModel
        view?.changeIndicatorState(state: false)
    }
}
