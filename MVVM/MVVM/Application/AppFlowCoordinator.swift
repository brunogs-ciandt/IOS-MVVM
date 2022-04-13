//
//  AppFlowCordinator.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import UIKit

class AppFlowCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        DIContainer.shared.registerDependencies()
        
        let mainStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        let loginController = mainStoryBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        
        let viewModel = DIContainer.shared.makeLoginViewModel {
            self.showCarFlow()
        }
        loginController.start(viewModel: viewModel)
        
        self.navigationController.pushViewController(loginController, animated: true)
    }
    
    func showCarFlow() {
        let mainStoryBoard = UIStoryboard(name: "CarMain", bundle: nil)
        let tabBarCar = mainStoryBoard.instantiateViewController(withIdentifier: "tabBarCar")
        
        let viewModel = DIContainer.shared.makeCarViewModel()
        
        //loginController.start(viewModel: viewModel)
        
        self.navigationController.pushViewController(tabBarCar, animated: true)
    }
}
