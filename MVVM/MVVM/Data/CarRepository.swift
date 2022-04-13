//
//  HttpRequest.swift
//  HttpRequest
//
//  Created by administrator on 4/7/22.
//

import Foundation

class CarRepository : ICarRepository {
    
    private var networkHttpService: INetworkService;
    
    init(networkHttpService: INetworkService) {
        self.networkHttpService = networkHttpService
    }
    
    public func getCars(completion: @escaping (Result<[Car], Error>) -> Void) {
        let baseUrl = "https://carangas.herokuapp.com/cars"
        networkHttpService.fetchRequest(url: baseUrl) { (result: Result<[Car], Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
                print("Error http request " + error.localizedDescription)
            }
        }
    }
}
