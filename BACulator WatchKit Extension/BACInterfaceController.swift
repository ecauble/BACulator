//
//  BACInterfaceController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import Foundation


class BACInterfaceController: WKInterfaceController {

    
    @IBOutlet var stopWatch: WKInterfaceTimer!
    @IBOutlet var BACLabel: WKInterfaceLabel!
    @IBOutlet var countLabel: WKInterfaceLabel!
    @IBOutlet var startStopButton: WKInterfaceButton!
    
    
    var usr = User()
    var timer : NSTimer?
    var drinkCount : Int = 0
    var timeZone = NSTimeZone(name: "UTC")
    var startTime : NSDate = NSDate()
    var timeSinceStart = 0.0
    let calc = Calculator()
    let duration : NSTimeInterval = 1
    let formatter:NSDateFormatter = NSDateFormatter()
    let defaults = DefaultsManager()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        addMenuItemWithImageNamed("reset-menu", title: "Reset Defaults", action: "resetDefaults")
       
    }
    
    func resetDefaults(){
        defaults.resetDefaults()
        self.pushControllerWithName("genderViewController", context: nil)
    }
    
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        stopWatch.setDate(NSDate())
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: "timerCount", userInfo: nil, repeats: true)
        self.startTime = usr.startTime!
        timer?.fire()
        stopWatch.start()
        
     }
    
    
    func timerCount() {
        let time: NSDate = NSDate()
        
        formatter.timeZone = timeZone
        formatter.dateFormat = "h:mm a"
        timeZone = NSTimeZone(name: "US/Eastern")
        formatter.timeZone = timeZone
        formatter.dateFormat = "h:mm a"
        self.timeSinceStart = time.timeIntervalSinceDate(startTime) / 60 / 60
        let BAC : Double = calc.calculateABV(usr.gender!, weight: usr.weight!, ABV: usr.beerABV!, timePassed: timeSinceStart, drinkCount: usr.drinkCount!)
        
        BACLabel.setText("≅" + String(BAC))
        if (calc.isOverLimit(BAC) == true){
            BACLabel.setTextColor(UIColor.redColor())
        }else{
            BACLabel.setTextColor(UIColor.greenColor())
        }

    }
    
    
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
        // Return data to be accessed in next interfaceController
        usr.drinkCount = self.drinkCount
        return usr
    }
    
    
    
    @IBAction func stopStartPressed() {
        
    }
    
    
    
    
    @IBAction func clearAndRest() {
        timer?.invalidate()
        stopWatch.stop()
        usr.startTime = NSDate()
        stopWatch.setDate(NSDate())
        usr.drinkCount = 0
        self.drinkCount = 0
        usr.startTime = NSDate()
        BACLabel.setText("≅ 0.0")
        BACLabel.setTextColor(UIColor.whiteColor())
        if defaults.isSet(K_DRINK_COUNT){
            defaults.setValue(usr.drinkCount, forKey: K_DRINK_COUNT)
            defaults.setValue(usr.startTime, forKey: K_START_TIME)
        }else{
           // self.pushControllerWithName("SwitchController", context: nil)

        }
    }
    
    
    @IBAction func addDrinkCalc() {
        
        
        
        drinkCount++
        usr.drinkCount = drinkCount
        countLabel.setText(String(drinkCount))
        defaults.setValue(usr.startTime, forKey: K_START_TIME)
        defaults.setValue(usr.drinkCount, forKey: K_DRINK_COUNT)
        let BAC : Double = calc.calculateABV(usr.gender!, weight: usr.weight!, ABV: usr.beerABV!, timePassed: timeSinceStart, drinkCount: usr.drinkCount!)

        BACLabel.setText("≅" + String(BAC))
        if (calc.isOverLimit(BAC) == true){
            BACLabel.setTextColor(UIColor.redColor())
        }else{
            BACLabel.setTextColor(UIColor.greenColor())
        }
        defaults.setDrinkCount(drinkCount)
        defaults.sync()
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
