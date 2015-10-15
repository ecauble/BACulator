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


class SwitchInterfaceController: WKInterfaceController {

    

    let defaults = DefaultsManager()

    var user = User()
    
 
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
   
     }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
 
       self.presentControllerWithName("SetGenderIC", context: nil)
      
    }

    @IBAction func buttonPressed() {
//        let messageString : String = "\(K_GENDER) : \(defaults.getGender()) , \(K_WEIGHT) : \(defaults.getWeight())"
//        let applicationData = ["messageString" : String(messageString) ]
//        print(applicationData)
//        
//        // The paired iPhone has to be connected via Bluetooth.
//        if let session = session where session.reachable {
//            session.sendMessage(applicationData,
//                replyHandler: { replyData in
//                    // handle reply from iPhone app here
//                    print(replyData)
//                }, errorHandler: { error in
//                    // catch any errors here
//                    print(error)
//            })
//        } else {
//            print("bluetooth goofed")
//        }
    }
 
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
 
    }

}
