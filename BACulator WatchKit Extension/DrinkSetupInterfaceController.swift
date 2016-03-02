//
//  DrinkSetupInterfaceController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/7/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import Foundation


class DrinkSetupInterfaceController: WKInterfaceController {
    
    @IBOutlet var drinkPicker: WKInterfacePicker!
    
    var items: [(String, String)]! = nil
    var ABV : Double?
    
    var bacModel = BACModel.sharedInstance
    let abvArray: [Double] = [0.049, 0.05, 0.056, 0.042]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
      
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        items = [("pils", "Pils ABV~4.9%"),("lager", "Lager ABV~5%"), ("IPA", "IPA ABV~5.6%"), ("stout", "Stout ABV~4.2%")]
        
        let pickerItems: [WKPickerItem] = items.map {
            let pickerItem = WKPickerItem()
            pickerItem.accessoryImage = WKImage(imageName: $0.0)
            pickerItem.title = $0.1
            return pickerItem
        }
        drinkPicker.setItems(pickerItems)
        drinkPicker.setSelectedItemIndex(1)
        
    }
    
    
    @IBAction func pickerSelectedItemChanged(value: Int) {
        self.ABV = abvArray[value]
    }
    
  
    
    @IBAction func doneButtonPressed() {
        let drink = DrinkObject.init(name: "asdf", volume: 12.0, abv: self.ABV!)
        bacModel.append(drink)
         self.pushControllerWithName("SetBAC", context: nil)
    }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
