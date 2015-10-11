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
    static let storageKey = "group.oopiedoopie.BACulator"
    
    let defaults = NSUserDefaults(suiteName: storageKey)
    
    
    func resetDefaults(){
        defaults!.removeObjectForKey(K_GENDER)
        defaults!.removeObjectForKey(K_WEIGHT)
        defaults!.removeObjectForKey(K_START_TIME)
        defaults!.removeObjectForKey(K_ABV)
        defaults!.removeObjectForKey(K_DRINK_COUNT)
    }
    
    
    func setGender(gender : Int){
        defaults?.setObject(gender, forKey: K_GENDER)
    }
    
    
    func setWeight(weight : Double){
        defaults?.setObject(weight, forKey: K_WEIGHT)
    }
    
    
    func setStartTime(startTime : NSDate){
        defaults?.setObject(startTime, forKey: K_START_TIME)
    }
    
    
    func setABV(beerABV : Double){
        defaults?.setObject(beerABV, forKey: K_ABV)
    }
    
    
    func setDrinkCount(drinkCount : Int){
        defaults?.setObject(drinkCount, forKey: K_DRINK_COUNT)
    }
    
    
    func getValueForKey(key : String) -> NSObject?{
        if let obj = defaults?.objectForKey(key){
            return obj as? NSObject
        }else {
            return nil
        }
    }
    
    func isSet(key : String) -> Bool{
        if let _ = defaults!.objectForKey(key){
            return true
        }else{
            return false
        }
    }
    
    func sync(){
        defaults?.synchronize()
    }
}

let K_GENDER        = "gender"
let K_WEIGHT        = "weight"
let K_ABV           = "beerABV"
let K_START_TIME    = "startTime"
let K_DRINK_COUNT   = "drinkCount"

