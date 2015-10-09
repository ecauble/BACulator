//
//  Calculator.swift
//  BACulator
//
//  Created by Eric Cauble on 10/8/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import Foundation

class Calculator {
    
    //constants
    //alcohol distrib. ratios
    let rGender : [Double] = [0.73, 0.66, 0.69]
    let beerOunces : Double = 12.0
    let ouncesConversion : Double = 5.14
    
    func calculateABV(genderAtIndex : Int, weight : Double, ABV : Double, timePassed : Double, drinkCount : Int) -> Double{
        
        let genderConst = rGender[genderAtIndex]
        let totalOuncesDrank : Double = Double(drinkCount) * beerOunces * ABV
        print("Oz = \(totalOuncesDrank)")
        
        //5.14 is used to convert liquid ounces to ounces of weight ie .823 x 100/16
        let BACpercentage = ((totalOuncesDrank * ouncesConversion) / (weight * genderConst)) - (0.015 * timePassed)
        print("BAC = \(BACpercentage)")
        return BACpercentage
    }
    
    func isOverLimit(myBAC : Double)->Bool{
        if(myBAC > 0.08){
            return true
        }else{
            return false
        }
    }
    
}