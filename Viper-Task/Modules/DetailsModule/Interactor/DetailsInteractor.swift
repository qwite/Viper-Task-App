import Foundation

// MARK: - DetailsInteractorInputProtocol
protocol DetailsInteractorInputProtocol {
    var presenter: DetailsInteractorOutputProtocol? { get set }
    var service: NetworkServiceProtocol { get set }
    
    init(service: NetworkServiceProtocol, fileService: FileServiceProtocol)
    
    func pullImageFromCache(order: ActiveOrder)
    func downloadImage(order: ActiveOrder)
    func createViewModel(order: ActiveOrder, imageData: Data)
    func fetchDetailedOrder(by id: Int)
}

// MARK: - DetailsInteractorOutputProtocol
protocol DetailsInteractorOutputProtocol: AnyObject {
    func configureView(viewModel: DetailedActiveOrderViewModel)
    func showError(message: String)
}

// MARK: - DetailsInteractorInputProtocol Implementation
class DetailsInteractor: DetailsInteractorInputProtocol {
    var service: NetworkServiceProtocol
    var fileService: FileServiceProtocol
    
    weak var presenter: DetailsInteractorOutputProtocol?
    
    required init(service: NetworkServiceProtocol, fileService: FileServiceProtocol) {
        self.service = service
        self.fileService = fileService
    }
    
    func pullImageFromCache(order: ActiveOrder) {
        guard let imageData = fileService.getImage(imageKey: order.vehicle.photo) else {
            self.downloadImage(order: order); return
        }
        
        self.createViewModel(order: order, imageData: imageData)
    }
    
    func downloadImage(order: ActiveOrder) {
        service.downloadImage(imageName: order.vehicle.photo, completion: { result in
            switch result {
            case .success(let data):
                self.createViewModel(order: order, imageData: data)
                
                guard self.fileService.saveImage(imageData: data, imageKey: order.vehicle.photo) == nil else {
                    self.presenter?.showError(message: Constants.Errors.downloadingImageError); return
                }
                
            case .failure(let error):
                self.presenter?.showError(message: Constants.Errors.downloadingImageError + " : \(error)")
            }
        })
    }
    
    func createViewModel(order: ActiveOrder, imageData: Data) {
        let viewModel = ActiveOrderMapper.convertDetail(from: order, image: imageData)
        self.presenter?.configureView(viewModel: viewModel)
    }
    
    func fetchDetailedOrder(by id: Int) {
        self.service.fetchActiveOrders(completion: { result in
            switch result {
            case .success(let orders):
                guard let order = orders.first(where: { $0.id == id }) else {
                    self.presenter?.showError(message: Constants.Errors.loadingOrdersError)
                    return
                }
                
                self.pullImageFromCache(order: order)
            case .failure(let error):
                self.presenter?.showError(message: Constants.Errors.loadingOrdersError + ": \(error)")
            }
        })
    }
}
