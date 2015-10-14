//
//  CustomBeerViewController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/13/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit

class CustomDrinkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    
    @IBOutlet weak var beerTextField: UITextField!
    @IBOutlet weak var ABVTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let defaults = DefaultsManager()
    
    //variables and constants
    var items : [(String, Double)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
     }
    
    override func viewDidAppear(animated: Bool) {
        
     }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return items.count
    }
  
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ABVTextField.resignFirstResponder()
        beerTextField.resignFirstResponder()

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "\(self.items[indexPath.row].0)      :       ABV \(self.items[indexPath.row].1 / 100)%"
        
        return cell
    }
    
   
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.ABVTextField.endEditing(true)
        self.beerTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        ABVTextField.resignFirstResponder()
        beerTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        if let drinkName = beerTextField.text{
            if let drinkABV = ABVTextField.text?.toDouble(){
                items.append(drinkName , drinkABV)
            tableView.reloadData()
            ABVTextField.text = ""
            beerTextField.text = ""
            }
        }else{
            print("not set")
        }
    }
    
    
    
    @IBAction func savePrefsButtonPressed(sender: AnyObject) {
        
     
        
    }
    
    
}


