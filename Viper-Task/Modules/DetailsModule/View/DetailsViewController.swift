import UIKit

// MARK: - DetailsViewProtocol
protocol DetailsViewProtocol: AnyObject {
    var presenter: DetailsPresenterProtocol! { get set }
    
    func configure(with viewModel: DetailedActiveOrderViewModelType)
    func changeIndicatorState(state: Bool)
}

// MARK: - UIViewController
class DetailsViewController: UIViewController {
    var presenter: DetailsPresenterProtocol!
    var detailsView = DetailsView()
        
    // MARK: Lifecycle
    override func loadView() {
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailsView.addIndicator()
    }
}

// MARK: - DetailsViewProtocol Implementation
extension DetailsViewController: DetailsViewProtocol {
    func configure(with viewModel: DetailedActiveOrderViewModelType) {
        detailsView.configure(viewModel: viewModel)
    }
    
    func changeIndicatorState(state: Bool) {
        state ? detailsView.startIndicator() : detailsView.stopIndicator()
    }
}
