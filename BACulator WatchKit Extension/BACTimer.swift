//
//  TimerInterfaceController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

 import Foundation


class BACTimer {
    
    var startTime : NSDate?
    let defaults = DefaultsManager()
    
     func getStartTime() -> NSDate {
        startTime = NSDate()
        defaults.setStartTime(startTime!)
        return startTime!
    }


}
