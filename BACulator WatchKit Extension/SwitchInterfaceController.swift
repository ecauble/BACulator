//
//  SwitchController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class SwitchInterfaceController: WKInterfaceController, WCSessionDelegate {

    
    private let session : WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    private var beerCount = 15

    let defaults = DefaultsManager()

    var usr = User()
    
    
    override init() {
        super.init()
        
        session?.delegate = self
        session?.activateSession()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
   
     }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
//        if defaults.isSet(K_GENDER){
//            print("defaults set")
//            usr.gender = defaults.getValueForKey(K_GENDER)as? Int
//            usr.weight = defaults.getValueForKey(K_WEIGHT) as? Double
//            usr.startTime = defaults.getValueForKey(K_START_TIME) as? NSDate
//            usr.beerABV = defaults.getValueForKey(K_ABV) as? Double
//            usr.drinkCount = defaults.getValueForKey(K_DRINK_COUNT) as? Int
//            self.pushControllerWithName("BACViewController", context: usr)
//            
//        }else{
//            print("no user defaults")
            //self.pushControllerWithName("genderViewController", context: nil)
        //}

        
       

        
    }

    @IBAction func buttonPressed() {
        
        let applicationData = [K_DRINK_COUNT : beerCount]
        
        // The paired iPhone has to be connected via Bluetooth.
        if let session = session where session.reachable {
            session.sendMessage(applicationData,
                replyHandler: { replyData in
                    // handle reply from iPhone app here
                    print(replyData)
                }, errorHandler: { error in
                    // catch any errors here
                    print(error)
            })
        } else {
            print("bluetooth goofed")
        }
    }
 
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
 
    }

}
