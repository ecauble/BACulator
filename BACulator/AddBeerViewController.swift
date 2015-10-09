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
    
    var beerCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        beerCountLabel.text = String(beerCounter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addBeer(sender: AnyObject) {
        beerCounter++
        beerCountLabel.text = String(beerCounter)
    }

}

