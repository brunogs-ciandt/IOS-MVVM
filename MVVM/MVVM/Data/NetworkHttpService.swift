//
//  NetworkService.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation

protocol INetworkService {
    typealias Completion<DataType> = (Result<DataType, Error>) -> Void
    
    func fetchRequest<DataType: Decodable>(url: String, result: @escaping Completion<DataType>)
}

class NetworkHttpService : INetworkService {
    
    private var urlSessionObject: URLSession
    
    init(urlSession: URLSession) {
        self.urlSessionObject = urlSession
    }
    
    func fetchRequest<DataType: Decodable>(url: String, result: @escaping (Result<DataType, Error>) -> Void) {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now()) {
                let baseUrl = URL(string: url)!
                self.urlSessionObject.dataTask(with: baseUrl) { data, response, error in
                    if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
                        if let data = data {
                            let responseData = try! JSONDecoder().decode(DataType.self, from: data)
                            DispatchQueue.main.async {
                                result(.success(responseData))
                            }
                        }
                    } else {
                        let responseError = error ?? NSError(domain: url, code: 500, userInfo: nil)
                        DispatchQueue.main.async {
                            result(.failure(responseError))
                        }
                    }
                }.resume()
            }
    }
}
