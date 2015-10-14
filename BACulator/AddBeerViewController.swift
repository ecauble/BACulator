//
//  ViewController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/7/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import WatchConnectivity


class AddBeerViewController: UIViewController {

    @IBOutlet weak var beerCountLabel: UILabel!
    private var counterData : Int?
    private let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    var beerCounter : Int = 0
    let defaults = DefaultsManager()
    
    
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
            print("beer count not set")
            beerCounter = 0
        }
        
        if(defaults.isSet(K_GENDER)){
            print("Gender is set = \(defaults.getGender())")
        }else{
            print("gender not set")
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addBeer(sender: AnyObject) {
        beerCounter++
        defaults.setDrinkCount(beerCounter)
        defaults.sync()
        beerCountLabel.text =  "\(beerCounter)"
    }

    deinit{
        print("beer count was deinit")
    }
}


// MARK: WCSessionDelegate
extension AddBeerViewController: WCSessionDelegate {
    
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

