//
//  SwitchController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import Foundation


class SwitchInterfaceController: WKInterfaceController {

    let prefs = NSUserDefaults.standardUserDefaults()

    var usr = User()

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        if let _ = prefs.objectForKey("gender"){
            print("defaults set")
            usr.gender = prefs.objectForKey("gender") as? Int
            usr.weight = prefs.objectForKey("weight") as? Double
            usr.startTime = prefs.objectForKey("startTime") as? NSDate
            usr.beerABV = prefs.objectForKey("beerABV") as? Double
            usr.drinkCount = prefs.objectForKey("drinkCount") as? Int
            self.pushControllerWithName("BACViewController", context: usr)
            
        }else{
            print("no user defaults")
            self.pushControllerWithName("genderViewController", context: nil)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
