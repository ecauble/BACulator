//
//  ViewController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/7/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit


class CulateViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var BACLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var beerCountLabel: UILabel!
    @IBOutlet weak var startStopButton: ODRoundButton!
    @IBOutlet var addDrinkButton: ODRoundButton!
    @IBOutlet var BACLabelTest: UILabel!
    

    var drinkCount : Int = 0
    var bacModel = BACModel.sharedInstance
    let calc = Calculator()
    let lableFormat = "0.0000000"
    var startTime = NSTimeInterval()
    var startDate : NSDate?
    var timer:NSTimer = NSTimer()
    let green = UIColor(rgba: "#6DFD6E")
    var images: [UIImage] = []
 
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        imageView.clipsToBounds = false
        imageView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        imageView.layer.shadowRadius = 5.0
        imageView.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        beerCountLabel.text = String(drinkCount)
        BACLabel.shadowColor = UIColor.blackColor()
        BACLabel.layer.shadowOpacity = 0.5
        BACLabel.shadowOffset = CGSize.init(width: 3, height: 3)
        beerCountLabel.shadowColor = UIColor.lightGrayColor()
        beerCountLabel.shadowOffset = CGSize.init(width: 3, height: 3)
        
        if(bacModel.userInfoAvailable()){
            //beerCountLabel.text = String(defaults.getDrinkCount())
            }else{
                drinkCount = 0
        }
        
        //load images array for animation
        for i in 1 ... 12{
            images.append(UIImage(named: "beer-glass-anim-\(i)")!)
        }
        
        imageView.animationImages = images
        imageView.animationDuration = 60.0
        startStopButton.hidden = true
    }



    @IBAction func addDrinkPressed(sender: AnyObject) {
        if(self.drinkCount < 1){
        startStopButtonPressed(self)
        startStopButton.hidden = false
        }
        bacModel.add(DrinkObject(name: "PBR" , volume: 12.0, abv: 0.5))
        beerCountLabel.text =  "\(drinkCount)"
        for obj in bacModel.items{
            print(obj.drinkName + String(arc4random()))
        }
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
        if(seconds > 20){
            beerCountLabel.textColor = UIColor.whiteColor()
        }
        else{
            beerCountLabel.textColor = UIColor(rgba: "#232635")
        }
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        let timePassed = NSDate().timeIntervalSinceDate(startDate!) / 60 / 60
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        timerLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        let BAC : Double = calc.calculateABV(bacModel.gender!, weight: bacModel.weight!, ABV: bacModel.items[0].drinkABV, timePassed: timePassed, drinkCount: drinkCount)
    
        BACLabel.text = "≅ " + (String(format: "%.7f", BAC)) + "%"
        if(calc.isNearLimit(BAC) == true){
            BACLabel.textColor = UIColor.yellowColor()
        }
        else if (calc.isOverLimit(BAC) == true){
            BACLabel.textColor = UIColor.redColor()
        }else{
            BACLabel.textColor = green
        }
    }

    @IBAction func startStopButtonPressed(sender: AnyObject) {
        if (!timer.valid) {
            let aSelector : Selector = #selector(CulateViewController.updateTime)
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
            drinkCount = 0
            beerCountLabel.text = String(drinkCount)
            //defaults.setDrinkCount(drinkCount)
            startStopButton.backgroundColor = UIColor(rgba: "#6DFD6E")
            imageView.stopAnimating()
            startStopButton.hidden = true
        }
    
    }
    
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("memory warning thrown")
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}




