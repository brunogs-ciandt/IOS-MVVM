//
//  ViewModelable.swift
//  MVVM
//
//  Created by administrator on 4/13/22.
//

import Foundation

protocol ViewModelable {
    func setViewModel<ViewModelType>(viewModel: ViewModelType)
}

protocol CarViewModelable {
    func loadCars(showCars: @escaping ([Car]) -> Void, showError: @escaping (String) -> Void)
}
