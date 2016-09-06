//
//  User.swift
//  BACulator
//
//  Created by Eric Cauble on 7/20/16.
//  Copyright © 2016 Oopie Doopie. All rights reserved.
//

import Foundation
import CoreData

@objc(Drink) class User: NSManagedObject {
    
    @NSManaged var gender: NSInteger
    @NSManaged var weight: Double
 
}
