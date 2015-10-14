//
//  GenderInterfaceController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import Foundation


class GenderInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var genderPicker: WKInterfacePicker!
    let defaults = DefaultsManager()
    var genderList: [(String, String)] = [("male", "Male"),("female", "Female"), ("undefined", "Undefined")]
    var gender : Int?
    var usr = User()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
      
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let pickerItems: [WKPickerItem] = genderList.map {
            let pickerItem = WKPickerItem()
            pickerItem.accessoryImage = WKImage(imageName: $0.0)
            pickerItem.title = $0.1
         
            return pickerItem
        }
        genderPicker.setItems(pickerItems)
        genderPicker.setSelectedItemIndex(1)

    }
    
    
    @IBAction func pickerSelectedItemChanged(value: Int) {
        self.gender = value
     }
    
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
        // Return data to be accessed in next interfaceController
        defaults.setGender(gender!)
        usr.gender = gender
        return usr
    }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
