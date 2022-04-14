//
//  ViewModelable.swift
//  MVVM
//
//  Created by administrator on 4/13/22.
//

import Foundation
import Combine

protocol ViewModelable {
    func setViewModel<ViewModelType>(viewModel: ViewModelType)
}

protocol CarViewModelable {
    var cars: Published<[Car]?>.Publisher { get }
    var error: Published<String?>.Publisher { get }
    
    func loadCars()
}
