//
//  ViewController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/7/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit

class AddBeerViewController: UIViewController {

    @IBOutlet weak var beerCountLabel: UILabel!
    
    var beerCounter : Int?
    let defaults = DefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        beerCountLabel.text = String(beerCounter)
        defaults.sync()
            beerCountLabel.text = String(defaults.getValueForKey(K_DRINK_COUNT)!)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addBeer(sender: AnyObject) {
        beerCounter = defaults.getValueForKey(K_DRINK_COUNT) as? Int
        beerCountLabel.text = String(beerCounter)
    }

    deinit{
        print("beer count was deinit")
    }
}

