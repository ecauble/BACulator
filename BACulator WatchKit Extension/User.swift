//
//  UserInfo.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import Foundation

class User {
    
    var gender : Int?
    var weight : Double?
    var beerABV : Double?
    var drinkCount : Int?
    var startTime : NSDate?
    
    init(){
       drinkCount = 0
    }
}