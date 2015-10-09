//
//  TimerInterfaceController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import Foundation


class TimerInterfaceController: WKInterfaceController {
    

    @IBOutlet var stopWatch: WKInterfaceTimer!
    
    
    var usr = User()
    var startTime : NSDate?
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let val: User = context as? User {
            print("passed value = \(val.beerABV)")
            self.usr = val
        }
        else{
            print("no value was set")
        }

    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        startTime = NSDate()
        stopWatch.setDate(startTime!)
        stopWatch.start()
    }

    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
        // Return data to be accessed in next interfaceController
        usr.startTime = self.startTime
        return usr
    }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    

}
