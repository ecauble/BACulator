//
//  BodySetupInterfaceController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/7/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import Foundation


class BodySetupInterfaceController: WKInterfaceController {

    @IBOutlet var weightPicker: WKInterfacePicker!
  
    var weightList: [Double] = []
    var weight : Double?
    let defaults = DefaultsManager()
    
    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
         for(var i : Int = 80 ; i < 305; i+=5){
            weightList.append(Double(i))
        }
        let pickerItems: [WKPickerItem] = weightList.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = String($0)
            return pickerItem
        }
        if(defaults.isSet(K_WEIGHT)){
            weight = defaults.getWeight()
            weightPicker.setItems(pickerItems)
            weightPicker.setSelectedItemIndex(weightList.indexOf(weight!)!)
            
        }else{
            weightPicker.setItems(pickerItems)
            weightPicker.setSelectedItemIndex(15)
        }
    }
    
    @IBAction func pickerSelectedItemChanged(value: Int) {
        self.weight = weightList[value]
        defaults.setWeight(weight!)
    }

  
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
