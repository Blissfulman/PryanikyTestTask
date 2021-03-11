//
//  NetworkService.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchViewData(completion: @escaping (Result<DataModel, Error>) -> Void)
}
    
final class NetworkService: NetworkServiceProtocol {
    
    private let requestService = RequestService()
    private let dataTaskService = DataTaskService()
    
    func fetchViewData(completion: @escaping (Result<DataModel, Error>) -> Void) {
        guard let url = URL(string: "https://pryaniky.com/static/json/sample.json") else { return }
        
        let request = requestService.request(url: url)
        
        dataTaskService.dataTask(request: request, completion: completion)
    }
}
