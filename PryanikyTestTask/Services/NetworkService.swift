//
//  NetworkService.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Alamofire
import Combine

protocol NetworkServiceProtocol {
    func fetchViewData(completion: @escaping (Result<DataModel, Error>) -> Void)
    func fetchDataWithCombine(completion: @escaping (Result<DataModel, Error>) -> Void)
}
    
final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Static properties
    
    static let shared = NetworkService.init()
    
    // MARK: - Properties
    
//    private let url = "https://pryaniky.com/static/json/sample.json"
//    private let url = "https://chat.pryaniky.com/json/data-custom-selected-id.json"
    private let url = URL(string: "https://chat.pryaniky.com/json/data-custom-order-much-more-items-in-data.json")!
    
    private var subsciptions = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public methods
    
    func fetchViewData(completion: @escaping (Result<DataModel, Error>) -> Void) {
        AF.request(url).responseDecodable(of: DataModel.self) { response in
            switch response.result {
            case .success(let dataModel):
                completion(.success(dataModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDataWithCombine(completion: @escaping (Result<DataModel, Error>) -> Void) {
        fetchData(forURL: url, completion: completion)
    }
    
    // MARK: - Private methods
    
    private func fetchData<T: Decodable>(forURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { data in
                completion(.success(data))
            })
            .store(in: &subsciptions)
    }
}


