//
//  DefaultsManager.swift
//  BACulator
//
//  Created by Eric Cauble on 10/10/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import Foundation

class DefaultsManager: NSObject {
    
    //constants
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    //mutators
    func setGender(gender : Int){
        defaults.setObject(gender, forKey: K_GENDER)
    }
    
    
    func setDrinkSelectionRow(row : Int){
        defaults.setObject(row, forKey: K_DRINK_SELECTION_ROW)
    }
    
    
    func setWeight(weight : Double){
        defaults.setObject(weight, forKey: K_WEIGHT)
    }
    
    
    func setStartTime(startTime : NSDate){
        defaults.setObject(startTime, forKey: K_START_TIME)
    }
    
    
    func setABV(beerABV : Double){
        defaults.setObject(beerABV, forKey: K_ABV)
    }
    
    
    func setDrinkCount(drinkCount : Int){
        defaults.setInteger(drinkCount, forKey: K_DRINK_COUNT)
    }
    
    func setDrinkArray(drinkArray : [AnyObject]){
        defaults.arrayForKey(K_DRINK_ARRAY)
    }
    
    
    //accessors
    func getGender() -> Int{
        return (defaults.integerForKey(K_GENDER))
    }
    
    func getWeight() -> Double{
        return (defaults.doubleForKey(K_WEIGHT))
    }
    
    func getStartTime() -> NSDate{
        return (defaults.objectForKey(K_START_TIME)) as! NSDate
    }
    
    func getABV()->Double{
        return (defaults.doubleForKey(K_ABV))
    }
    
    func getDrinkCount() -> Int{
        return (defaults.integerForKey(K_DRINK_COUNT))
    }
    
    func getDrinkSelectionRow() -> Int{
        return (defaults.integerForKey(K_DRINK_SELECTION_ROW))
    }
 
    func getDrinkArray() -> Array<AnyObject>{
        return (defaults.arrayForKey(K_DRINK_ARRAY))!
    }
    
    //class functions
    func isSet(key : String) -> Bool{
        if let _ = defaults.objectForKey(key){
            return true
        }else{
            return false
        }
    }
    
    
    func sync(){
        defaults.synchronize()
    }
    
    
    func resetDefaults(){
        defaults.removeObjectForKey(K_GENDER)
        defaults.removeObjectForKey(K_WEIGHT)
       // defaults.removeObjectForKey(K_START_TIME)
        defaults.removeObjectForKey(K_ABV)
        defaults.removeObjectForKey(K_DRINK_COUNT)
    }
    
}

let K_GENDER        = "k_gender"
let K_WEIGHT        = "k_weight"
let K_ABV           = "k_ABV"
let K_START_TIME    = "k_startTime"
let K_DRINK_COUNT   = "k_drinkCount"
let K_DRINK_SELECTION_ROW = "K_drinkSelectionRow"
let K_DRINK_ARRAY = "k_drinkArray"
