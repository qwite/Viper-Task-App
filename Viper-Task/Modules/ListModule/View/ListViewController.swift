import UIKit

// MARK: - ListViewProtocol
protocol ListViewProtocol: AnyObject {
    func configureTableView()
    func updateTableView()
    
    func changeIndicatorState(state: Bool)
}

// MARK: - ListViewController
class ListViewController: UIViewController {
    
    // MARK: Properties
    var presenter: ListPresenterProtocol!
    var tableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
}

// MARK: - ListViewProtocol Implementation
extension ListViewController: ListViewProtocol {
    func changeIndicatorState(state: Bool) {
        state ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func configureTableView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(AddressCell.self, forCellReuseIdentifier: AddressCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView = tableView
        view.addSubview(self.tableView)
        
        // tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateTableView() {
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.Headers.listTableViewHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getViewModelCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseId) as? AddressCell,
              let viewModel = presenter.getItemViewModel(at: indexPath.row) else {
            fatalError("dequeueReusableCell error")
        }
        
        cell.configureCell(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didItemSelected(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
