//
//  NetworkService.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Alamofire

protocol NetworkServiceProtocol {
    func fetchViewData(completion: @escaping (Result<DataModel, Error>) -> Void)
}
    
final class NetworkService: NetworkServiceProtocol {
    
    private let url = "https://pryaniky.com/static/json/sample.json"
    
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
}
