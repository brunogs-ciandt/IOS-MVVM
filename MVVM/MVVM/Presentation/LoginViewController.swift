//
//  FirstViewController.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import UIKit

class LoginViewController: UIViewController {

    private var viewModel: LoginViewModel!
    
    func start(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.viewModel.executeNextFlow()
    }
}
