//
//  CarsTableViewController.swift
//  MVVM
//
//  Created by administrator on 4/12/22.
//

import UIKit

class CarsTableViewController: UITableViewController {

    
    var viewModel: CarViewModel!
    var cars: [Car] = []
    
    let lblMessage = UILabel()
    let activity = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblMessage.text = "Nao existem carros"
        lblMessage.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cars = []
        activity.startAnimating()
        viewModel.loadCars(showCars: showCarList, showError: showError)
        tableView.reloadData()
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Erro ao listar os carros", message: error)
        activity.stopAnimating()
        tableView.reloadData()
    }
    
    private func showCarList(_ cars: [Car]) {
        self.cars = cars
        activity.stopAnimating()
        tableView.reloadData()
    }
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = activity.isAnimating ? activity : cars.count == 0 ? lblMessage : nil
        
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell

        let car = cars[indexPath.row]
        cell.prepareCarCell(car: car)

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
}

extension CarsTableViewController : ViewModelable {
    func setViewModel<ViewModelType>(viewModel: ViewModelType) {
        self.viewModel = viewModel as? CarViewModel
    }
}
