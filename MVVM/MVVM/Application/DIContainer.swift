//
//  DIContainer.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation
import Swinject

class DIContainer {
    static let shared: DIContainer = DIContainer()
    
    let currentContainer: Container = Container()
    
    func registerDependencies() {
        registerNetwork()
        
        registerRepositories()
        
        registerUserCase()
    }
    
    func makeLoginViewModel(showNextFlow: @escaping () -> Void) -> LoginViewModel {
       return LoginViewModel(showNextFlow: showNextFlow)
    }
    
    func makeCarViewModel() -> CarViewModel {
        let carUseCase = currentContainer.resolve(CarUseCase.self)!
        return CarViewModel(carUseCase: carUseCase)
    }
    
    private func registerNetwork(){
        let configuration: URLSessionConfiguration = {
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Content-Type:": "application/json"]
            return config
        }()
        
        let urlSession = URLSession(configuration: configuration)
        let networkService = NetworkHttpService(urlSession: urlSession)
        currentContainer.register(INetworkService.self, name: nil) { _ in
            networkService
        }
    }
    
    private func registerRepositories() {
        let networkService = currentContainer.resolve(INetworkService.self)!

        let carRepository = CarRepository(networkHttpService: networkService)
        currentContainer.register(ICarRepository.self, name: nil) { _ in
            carRepository
        }
    }
    
    private func registerUserCase(){
        let carRepository = currentContainer.resolve(ICarRepository.self)!
        
        currentContainer.register(CarUseCase.self, name: nil) { _ in
            CarUseCase(repository: carRepository)
        }
    }
}
