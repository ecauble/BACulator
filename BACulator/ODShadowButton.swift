//
//  ODButton.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//


import UIKit

class ODShadowButton: UIButton
{
    //add style to generic UIButton
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.cornerRadius = 0
    }
    
    
    
}
