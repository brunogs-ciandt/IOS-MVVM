//
//  CarViewModel.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation

class CarViewModel : CarViewModelable {
    var carUseCase: CarUseCase!
    
    init(carUseCase: CarUseCase) {
        self.carUseCase = carUseCase
    }
    
    func loadCars(showCars: @escaping ([Car]) -> Void, showError: @escaping (String) -> Void) {
        self.carUseCase.getCars { result in
            switch result {
                case .success(let data):
                    showCars(data)
                case .failure(let error):
                    showError(error.localizedDescription)
            }
        }
    }
    
}
