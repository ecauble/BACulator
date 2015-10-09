//
//  SettingsViewController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var setGenderButton: UIButton!
    @IBOutlet weak var setWeightTextField: UITextField!
    @IBOutlet weak var beerNameTextField: UITextField!
    @IBOutlet weak var setABVTextFeield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var beerCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setGender(sender: AnyObject) {
        
    }
  
    @IBAction func addCustomDrink(sender: AnyObject) {
        
    }
    
}