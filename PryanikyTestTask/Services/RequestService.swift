//
//  RequestService.swift
//  PryanikyTestTask
//
//  Created by Evgeny Novgorodov on 11.03.2021.
//

import Foundation

protocol RequestServiceProtocol {
    func request(url: URL) -> URLRequest
}

final class RequestService: RequestServiceProtocol {
    
    func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
