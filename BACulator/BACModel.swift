//
//  BACModel.swift
//  BACulator
//
//  Created by Eric Cauble on 2/18/16.
//  Copyright © 2016 Oopie Doopie. All rights reserved.
//

import Foundation

struct BACModel {
    
    private(set) var items: [String] = []
    var gender : Int
    var weight : Double
    var drinkArray : Array(String:)
    
    init() {
        items = load()
    }
    
    mutating func append(item: String) {
        items.append(item)
        save(items)
    }
    
    mutating func removeItemAt(index: Int) {
        items.removeAtIndex(index)
        save(items)
    }
    
    func save(items: [String]) {
        defaults?.setObject(items, forKey: itemsKey)
        print(defaults?.synchronize())
    }
    func load() -> [String] {
        return defaults?.objectForKey(itemsKey) as? [String] ?? []
    }
    
    private let itemsKey = "items"
    private let defaults = NSUserDefaults(suiteName: "group.com.oopiedoopie.BACulator")
}