//
//  BACInterfaceController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class BACInterfaceController: WKInterfaceController, WCSessionDelegate {

    
    @IBOutlet var stopWatch: WKInterfaceTimer!
    @IBOutlet var BACLabel: WKInterfaceLabel!
    @IBOutlet var countLabel: WKInterfaceLabel!
    @IBOutlet var startStopButton: WKInterfaceButton!
    
    var drinkCount : Int = 0
    var timeZone = NSTimeZone(name: "UTC")
    let defaults = DefaultsManager()
    let calc = Calculator()
    var startTime = NSTimeInterval()
    var startDate : NSDate?
    var timer : NSTimer = NSTimer()
    let green = UIColor(rgba: "#6DFD6E")
    var gender = 0
    var weight = 0.0
    var abv = 0.0
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        gender = defaults.getGender()
        weight = defaults.getWeight()
        abv = defaults.getABV()
        // Configure interface objects here.
        if WCSession.isSupported() {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        addMenuItemWithItemIcon(WKMenuItemIcon.Trash, title: "Reset", action: "resetDefaults")
    }
    
    func resetDefaults(){
        defaults.resetDefaults()
        self.popController()
    }
    
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
      }
    
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
       
        //needed for BAC calculation
        let timePassed = NSDate().timeIntervalSinceDate(startDate!) / 60 / 60
        
        let BAC : Double = calc.calculateABV(gender, weight: weight, ABV: abv, timePassed: timePassed, drinkCount:drinkCount)

        BACLabel.setText("≅ " + (String(format: "%.5f", BAC)) + "%") 
        if(calc.isNearLimit(BAC) == true){
            BACLabel.setTextColor(UIColor.yellowColor())
        }
        else if (calc.isOverLimit(BAC) == true){
           BACLabel.setTextColor(UIColor.redColor())
        }else{
            BACLabel.setTextColor(green)
        }
    }
    
   
    @IBAction func stopStartPressed() {
        if (!timer.valid) {
            stopWatch.start()
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            startDate = NSDate()
            startStopButton.setBackgroundColor(UIColor.redColor())
            startStopButton.setTitle("Reset")
        }
        else{
            stopWatch.stop()
            let newTime = NSDate()
            stopWatch.setDate(newTime)
            //stop and reset lables and variables
            timer.invalidate()
            startStopButton.setTitle("Start")
            BACLabel.setText("≅ 0.00000%")
            BACLabel.setTextColor(UIColor.whiteColor())
            drinkCount = 0
            countLabel.setText(String(drinkCount))
            defaults.setDrinkCount(drinkCount)
            startStopButton.setBackgroundColor(UIColor(rgba: "#6DFD6E"))
            
        }
 
    }
    

    
    
    @IBAction func addDrinkCalc() {
   
        drinkCount++
        countLabel.setText("\(drinkCount)")
        defaults.setDrinkCount(drinkCount)
//        let message = ["wk_DrinkCount": String(drinkCount)]
//        WCSession.defaultSession().transferUserInfo(message)
    }
    
  

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
