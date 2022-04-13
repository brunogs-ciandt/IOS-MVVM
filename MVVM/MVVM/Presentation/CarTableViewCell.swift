//
//  CarTableViewCell.swift
//  MVVM
//
//  Created by administrator on 4/13/22.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var viewRow: UIView!
    
    @IBOutlet weak var lblNameCar: UILabel!
    @IBOutlet weak var lblFuel: UILabel!
    @IBOutlet weak var lblMarca: UILabel!
    
    @IBOutlet weak var viewLeft: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCarCell(car: Car) {
        
        viewRow.layer.cornerRadius = 10
        viewRow.clipsToBounds = true
        
        viewRow.layer.shadowColor = UIColor.gray.cgColor
        viewRow.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewRow.layer.shadowRadius = 10
        viewRow.layer.shadowOpacity = 0.5
        //viewRow.layer.masksToBounds = false
        
        lblFuel.text = car.gasName
        lblMarca.text = car.brand
        lblNameCar.text = car.name
    }

}
