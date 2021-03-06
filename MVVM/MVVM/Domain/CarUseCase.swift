//
//  CarUseCase.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation

class CarUseCase {
    private var carRepository: CarRepositorable;
    
    init(repository: CarRepositorable) {
        self.carRepository = repository
    }
    
    func getCars(completionCar: @escaping (Result<[Car], Error>) -> Void) -> Void {
            self.carRepository.getCars { result in
                completionCar(result)
            }
    }
}
