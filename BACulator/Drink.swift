//
//  Drink.swift
//  BACulator
//
//  Created by Eric Cauble on 7/20/16.
//  Copyright © 2016 Oopie Doopie. All rights reserved.
//

import Foundation
import CoreData

@objc(Drink) class Drink: NSManagedObject {
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var volume: Double
    @NSManaged var abv: Double
    @NSManaged var dateCreated: NSDate
}


