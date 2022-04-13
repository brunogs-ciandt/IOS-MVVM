//
//  LoginViewModel.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import Foundation

class LoginViewModel {
   
    var showNextFlow: () -> Void
    
    init(showNextFlow: @escaping () -> Void) {
        self.showNextFlow = showNextFlow
    }
    
    func executeNextFlow() {
        self.showNextFlow()
    }
}
