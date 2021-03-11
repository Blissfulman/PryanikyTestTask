//
//  DataTaskService.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Foundation

protocol DataTaskServiceProtocol {
    func dataTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

final class DataTaskService: DataTaskServiceProtocol {
    
    func dataTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void){
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                print("Receive HTTP response error")
                return
            }
            
            print(httpResponse.statusCode, request.url?.path ?? "")
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                if !data.isEmpty {
                    print(error.localizedDescription)
                }
                completion(.failure(error))
            }
        }.resume()
    }
}
