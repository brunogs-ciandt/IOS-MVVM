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
        let tabBarCarController = mainStoryBoard.instantiateViewController(withIdentifier: "tabBarCar") as! UITabBarController
        
        if let viewControllers = tabBarCarController.viewControllers, let nav = viewControllers as? [UINavigationController] {
            nav.forEach { controller in
                if let vc = controller.viewControllers.first, let vm = vc as? ViewModelable {
                    let viewModel = DIContainer.shared.makeCarViewModel()
                    vm.setViewModel(viewModel: viewModel)
                }
            }
        }
        
        tabBarCarController.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController.pushViewController(tabBarCarController, animated: true)
    }
}
