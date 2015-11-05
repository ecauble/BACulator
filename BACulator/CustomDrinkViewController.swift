//
//  CustomBeerViewController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/13/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit

class CustomDrinkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    //outlets
    @IBOutlet weak var beerTextField: UITextField!
    @IBOutlet weak var ABVTextField: UITextField!
    @IBOutlet weak var ouncesTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //variables and constants
    let defaults = DefaultsManager()
    var items : [(String, String, Double, Double)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items.append(("blank-drink", "Pilsner", 0.049, 12.0))
        items.append(("blank-drink","Lager", 0.050, 12.0))
        items.append(("blank-drink", "IPA", 0.056, 12.0))
        items.append(("blank-drink", "Stout", 0.042, 12.0))
        
        
        //load nib for custom UITableViewCell
        let nib = UINib(nibName: "CustomDrinkCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        if let selectedRow : Int = defaults.getDrinkSelectionRow(){
             let path = NSIndexPath(forRow: selectedRow, inSection: 1)
            tableView.selectRowAtIndexPath(path, animated: false, scrollPosition:
                UITableViewScrollPosition.None);
            tableView.cellForRowAtIndexPath(path)?.accessoryType = .Checkmark
        }
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
        defaults.setABV(items[indexPath.row].2)
        defaults.setDrinkSelectionRow(indexPath.row)
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomDrinkCell
        cell.loadItem(items[indexPath.row].0, drinkName: items[indexPath.row].1, abv: String(items[indexPath.row].2), ounces: String(items[indexPath.row].3))
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            items.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
   
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.ABVTextField.endEditing(true)
        self.beerTextField.endEditing(true)
        self.ouncesTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        ABVTextField.resignFirstResponder()
        beerTextField.resignFirstResponder()
        ouncesTextField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        if let drinkName = beerTextField.text{
            if let drinkABV = ABVTextField.text?.toDouble(){
                if let ounces = ouncesTextField.text?.toDouble(){
                let image = "blank-drink"
                items.append(image, drinkName, drinkABV, ounces)
                tableView.reloadData()
                ABVTextField.text = ""
                beerTextField.text = ""
                ouncesTextField.text = ""
            }
        }
        }else{
            print("not set")
        }
     }
    
    
    
 
    
    
}


