import Foundation
import Alamofire

// MARK: - NetworkServiceProtocol
protocol NetworkServiceProtocol {
    func fetchActiveOrders(completion: @escaping (Result<[ActiveOrder], Error>) -> ())
    func getImage(imageName: String, completion: @escaping (Result<Data, Error>) -> ())
}

// MARK: - NetworkServiceProtocol Implementation
class NetworkService: NetworkServiceProtocol {
    func fetchActiveOrders(completion: @escaping (Result<[ActiveOrder], Error>) -> ()) {
        AF.request(Constants.Endpoints.orders, method: .get).responseDecodable(of: [ActiveOrder].self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImage(imageName: String, completion: @escaping (Result<Data, Error>) -> ()) {
        AF.request(Constants.Endpoints.images + imageName).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
