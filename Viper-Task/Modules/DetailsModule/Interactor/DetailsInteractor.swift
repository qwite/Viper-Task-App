import Foundation

// MARK: - DetailsInteractorInputProtocol
protocol DetailsInteractorInputProtocol {
    var presenter: DetailsInteractorOutputProtocol? { get set }
    var service: NetworkServiceProtocol { get set }
    
    init(service: NetworkServiceProtocol, fileService: FileServiceProtocol)
    
    func getImage(order: ActiveOrder)
    func downloadImage(order: ActiveOrder)
    func createViewModel(order: ActiveOrder, imageData: Data)
    func getDetailedOrder(by id: Int)
}

// MARK: - DetailsInteractorOutputProtocol
protocol DetailsInteractorOutputProtocol: AnyObject {
    func setViewModel(viewModel: DetailedActiveOrderViewModelType)
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
    
    func getImage(order: ActiveOrder) {
        guard let imageData = fileService.getImage(imageKey: order.vehicle.photo) else {
            downloadImage(order: order); return
        }
        
        print("[Log] Getting file from a cache...")
        createViewModel(order: order, imageData: imageData)
    }
    
    func downloadImage(order: ActiveOrder) {
        print("[Log] Downloading a photo...")
        
        service.getImage(imageName: order.vehicle.photo, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.createViewModel(order: order, imageData: data)
                self?.fileService.saveImage(imageData: data, imageKey: order.vehicle.photo)
            case .failure(let error):
                self?.presenter?.showError(message: Constants.Errors.downloadingImageError + " : \(error)")
            }
        })
    }
    
    func createViewModel(order: ActiveOrder, imageData: Data) {
        let viewModel = ActiveOrderMapper.convertDetail(from: order, image: imageData)
        presenter?.setViewModel(viewModel: viewModel)
    }
    
    func getDetailedOrder(by id: Int) {
        service.fetchActiveOrders(completion: { [weak self] result in
            switch result {
            case .success(let orders):
                guard let order = orders.first(where: { $0.id == id }) else {
                    self?.presenter?.showError(message: Constants.Errors.loadingOrdersError)
                    return
                }
                
                self?.getImage(order: order)
            case .failure(let error):
                self?.presenter?.showError(message: Constants.Errors.loadingOrdersError + ": \(error)")
            }
        })
    }
}
