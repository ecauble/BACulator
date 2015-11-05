//
//  CustomDrinkCell.swift
//  BACulator
//
//  Created by Eric Cauble on 11/4/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit

class CustomDrinkCell : UITableViewCell {
    

    @IBOutlet var drinkImage: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkABVLabel: UILabel!
    @IBOutlet weak var drinkOuncesLabel: UILabel!
    
    func loadItem(imageName: String, drinkName: String,  abv : String, ounces : String ) {
        drinkImage.image = UIImage(named: imageName)
        drinkNameLabel.text = drinkName
        drinkABVLabel.text = abv
        drinkOuncesLabel.text = ounces
    }
}
