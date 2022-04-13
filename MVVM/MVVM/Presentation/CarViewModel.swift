//
//  CarViewModel.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation

class CarViewModel {
    var carUseCase: CarUseCase!
    
    init(carUseCase: CarUseCase) {
        self.carUseCase = carUseCase
    }
    
}
