//
//  DrinkObject.swift
//  BACulator
//
//  Created by Eric Cauble on 2/21/16.
//  Copyright © 2016 Oopie Doopie. All rights reserved.
//

import Foundation

class DrinkObject {
    
    //instance vars
    var drinkName : String
    var drinkVolume : Double
    var drinkABV : Double
    var drinkCount = 0
    
    //initializer
    init(name: String, volume : Double, abv : Double){
        drinkName = name
        drinkVolume = volume
        drinkABV = abv
        drinkCount = 0
    }
    
    func addDrink(){
        self.drinkCount++
    }
    
    
    
    
}