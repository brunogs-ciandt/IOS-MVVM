//
//  CarViewModel.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation
import Combine

class CarViewModel : CarViewModelable {
    @Published private var carList: [Car]!
    @Published private var errorMessage: String!
    
    var cars: Published<[Car]?>.Publisher {
        $carList
    }
    
    var error: Published<String?>.Publisher {
        $errorMessage
    }
    
    var carUseCase: CarUseCase!
    
    init(carUseCase: CarUseCase) {
        self.carUseCase = carUseCase
    }
    
    func loadCars() {
        self.carUseCase.getCars { result in
            switch result {
                case .success(let data):
                    self.carList = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
}
