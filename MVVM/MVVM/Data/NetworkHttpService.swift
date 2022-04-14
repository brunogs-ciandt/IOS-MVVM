//
//  NetworkService.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation
import Alamofire

protocol INetworkService {
    typealias Completion<DataType> = (Result<DataType, Error>) -> Void
    
    func fetchRequest<DataType: Decodable>(url: String, result: @escaping Completion<DataType>)
    
    func loadCarsWithAlamofire()
}

struct Login: Encodable {
    var email: String
    var password: String
}

struct LoginResponse: Codable {
    var avatar: String
    var name: String
    var email: String
    var token: String
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
    
    func loadCarsWithAlamofire() {
        let task = DispatchWorkItem{
            self.getDataAlamofire { (result: Result<LoginResponse, Error>) in
                
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now(), execute: task)
    }
    
    private func getDataAlamofire<DataType: Decodable>(result: @escaping (Result<DataType, Error>) -> Void) {
        print("TRACE - main thread \(Thread.current.isMainThread) - Iniciando Alamofire Http Request \(Date.now)")
        
        let login = Login(email: "iosbootcamp1@ciandt.com", password: "strongpwd")
        
        
        AF.request("http://localhost:3000/api/login", method: .post, parameters: login)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: DataType.self, completionHandler: { response in
                print("TRACE - main thread \(Thread.current.isMainThread) - Alamofire Finalizado Http Request \(Date.now)")
                
                print(response.response!.statusCode)
                
                switch response.result {
                    case .success(let value):
                        result(.success(value))
                        print("Success")
                    case .failure(let error):
                        switch response.response?.statusCode {
                            case 401:
                                result(.failure(error))
                            default:
                                result(.failure(error))
                        }
                }
            })
    }
}
