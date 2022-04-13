//
//  CarRepository.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation

protocol ICarRepository {
    func getCars(completion: @escaping (Result<[Car], Error>) -> Void) -> Void
}
