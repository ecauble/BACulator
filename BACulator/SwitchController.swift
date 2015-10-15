//
//  SwitchController.swift
//  BACulator
//
//  Created by Eric Cauble on 10/14/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import Foundation
import UIKit
class SwitchController: UITabBarController, UITabBarControllerDelegate {
    let defaults = DefaultsManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_main_queue()) {

            if(self.defaults.isSet(K_GENDER) && self.defaults.isSet(K_WEIGHT) && self.defaults.isSet(K_ABV)){
            let controller = BACulateViewController()
            self.navigationController?.presentViewController(controller, animated: true, completion: nil)
        }
        }
    }
}