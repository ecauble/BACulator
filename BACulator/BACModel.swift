//
//  BACModel.swift
//  BACulator
//
//  Created by Eric Cauble on 2/18/16.
//  Copyright © 2016 Oopie Doopie. All rights reserved.
//

import Foundation

struct BACModel {
    
    private(set) var items: [DrinkObject] = []
    private(set) var gender : Int?
    private(set) var weight : Double?
    
    init() {
        items = load()
        gender = defaults?.integerForKey(genderKey)
        weight = defaults?.doubleForKey(weightKey)
    }
    
    
    
    mutating func append(item: DrinkObject) {
        items.append(item)
        save(items)
    }
    
    mutating func removeItemAt(index: Int) {
        items.removeAtIndex(index)
        save(items)
    }
    
    func save(items: [DrinkObject]) {
        defaults?.setObject(items, forKey: itemsKey)
        print(defaults?.synchronize())
    }
    
    func saveGender(gender: Int){
        defaults?.setObject(gender, forKey: genderKey)
        print(defaults?.synchronize())
    }
    
    func saveWeight(){
        defaults?.setObject(weight, forKey: weightKey)
        print(defaults?.synchronize())
    }
    
    func load() -> [DrinkObject] {
        return defaults?.objectForKey(itemsKey) as? [DrinkObject] ?? []
    }
    
    private let itemsKey = "items"
    private let genderKey = "gender"
    private let weightKey = "weight"
    private let defaults = NSUserDefaults(suiteName: "group.com.oopiedoopie.BACulator")
}