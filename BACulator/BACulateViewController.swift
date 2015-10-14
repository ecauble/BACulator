//
//  ViewController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/7/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import WatchConnectivity


class BACulateViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var BACLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var beerCountLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    
    private var counterData : Int?
    private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    var beerCounter : Int = 0
    let defaults = DefaultsManager()
    let calc = Calculator()
    let lableFormat = "0.0000000"
    var startTime = NSTimeInterval()
    var startDate : NSDate?
    var timer:NSTimer = NSTimer()
    let green = UIColor(rgba: "#6DFD6E")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureWCSession()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configureWCSession()
    }
    
    private func configureWCSession() {
        session?.delegate = self;
        session?.activateSession()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        beerCountLabel.text = String(beerCounter)
        defaults.sync()
        if(defaults.isSet(K_DRINK_COUNT)){
        beerCountLabel.text = String(defaults.getDrinkCount())
        }else{
            beerCounter = 0
        }
        
        let a = defaults.getGender()
        let b = defaults.getABV()
        let c = defaults.getDrinkCount()
        let d = defaults.getDrinkSelectionRow()
        //let e = defaults.getStartTime()
        let f = defaults.getWeight()
        
        
        print("gender \(a) weight \(f) abv \(b)  drinkCount \(c)  row \(d)")
        
        for(var i = 0; i < 13 ; i++){
            imageView.animationImages?.append(UIImage(named: "beer-glass-anim-\(i)")!)
         }
        
        imageView.animationImages = [UIImage(named: "beer-glass-anim-1")!,UIImage(named: "beer-glass-anim-2")!,UIImage(named: "beer-glass-anim-3")!,UIImage(named: "beer-glass-anim-4")!,UIImage(named: "beer-glass-anim-5")!,UIImage(named: "beer-glass-anim-6")!,UIImage(named: "beer-glass-anim-7")!,UIImage(named: "beer-glass-anim-8")!,UIImage(named: "beer-glass-anim-9")!,UIImage(named: "beer-glass-anim-10")!,UIImage(named: "beer-glass-anim-11")!,UIImage(named: "beer-glass-anim-12")!]
        //55 seconds to go through a full animation in one minute
        imageView.animationDuration = 60.0
     
       // stopWatch.start()
    }



    @IBAction func addBeer(sender: AnyObject) {
        beerCounter++
        beerCountLabel.text =  "\(beerCounter)"
        defaults.setDrinkCount(beerCounter)
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
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        let timePassed = NSDate().timeIntervalSinceDate(startDate!) / 60 / 60
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        timerLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        let BAC : Double = calc.calculateABV(defaults.getGender(), weight: defaults.getWeight(), ABV: defaults.getABV(), timePassed: timePassed, drinkCount:beerCounter)
    
        BACLabel.text = "≅ " + (String(format: "%.7f", BAC)) + "%"
        if (calc.isOverLimit(BAC) == true){
            BACLabel.textColor = UIColor.redColor()
        }else{
            BACLabel.textColor = green
        }
    }

    @IBAction func startStopButtonPressed(sender: AnyObject) {
        if (!timer.valid) {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            startDate = NSDate()
            startStopButton.backgroundColor = UIColor.redColor()
            startStopButton.setTitle("Reset", forState: .Normal)
            imageView.startAnimating()
        }
        else{
            //stop and reset lables and variables
            timer.invalidate()
            startStopButton.setTitle("Start", forState: .Normal)
            timerLabel.text = "00:00:00"
            BACLabel.text = "≅ 0.0000000%"
            BACLabel.textColor = UIColor.whiteColor()
            beerCounter = 0
            beerCountLabel.text = String(beerCounter)
            defaults.setDrinkCount(beerCounter)
            startStopButton.backgroundColor = UIColor(rgba: "#6DFD6E")
            imageView.stopAnimating()
        }
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}




// MARK: WCSessionDelegate
extension BACulateViewController: WCSessionDelegate {
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        dispatch_async(dispatch_get_main_queue()) {
            if let counterValue = message[K_DRINK_COUNT] as? Int {
                self.counterData = counterValue
                self.beerCountLabel.text = String(counterValue)
            }
        }
    }
    
}

