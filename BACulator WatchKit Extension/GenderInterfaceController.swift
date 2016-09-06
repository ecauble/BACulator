//
//  GenderInterfaceController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation


class GenderInterfaceController: WKInterfaceController {
    
    
    @IBOutlet var genderPicker: WKInterfacePicker!
    //constants
    var genderList: [String] = ["Male","Female","Undefined"]
    var gender : Int?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if(true){
            self.pushControllerWithName("SetDrinkIC", context: nil)
         
        }
        
        let pickerItems: [WKPickerItem] = genderList.map {
            let pickerItem = WKPickerItem()
            pickerItem.accessoryImage = WKImage(imageName: $0.lowercaseString)
            pickerItem.title = $0
         
            return pickerItem
        }
        if(false){
            gender = self.gender
            genderPicker.setItems(pickerItems)
            genderPicker.setSelectedItemIndex(gender!)
          }else{
            genderPicker.setItems(pickerItems)
            genderPicker.setSelectedItemIndex(1)
        }
    }
    
    
    @IBAction func pickerSelectedItemChanged(value: Int) {
        self.gender = value
     }
    
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        // Return data to be accessed in next interfaceController
         bacModel.setGender(gender!)
        return gender
     }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
