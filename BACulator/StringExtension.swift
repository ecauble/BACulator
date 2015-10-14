//
//  StringExtension.swift
//  BACulator
//
//  Created by Eric Cauble on 10/14/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}