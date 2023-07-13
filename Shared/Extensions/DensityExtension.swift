//
//  DensityExtension.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation

/*
 This method returns a Unit with an associated converter, whereas units initialized from a string using the
 `Unit(symbol:)` initializer do not have a converter associated and thereby don't support conversion.
 */
extension Density {
    static func fromString(_ string: String) -> Density {
        //Example: 5 g per cup
        let components = string.split(separator: " ")
        let massValue = Double(components[0]) ?? 0.0
        let volumeValue = Double(components[3]) ?? 0.0
        let massUnit: UnitMass = .fromSymbol(String(components[1]))
        let volumeUnit: UnitVolume = .fromSymbol(String(components[4]))
        
        return Density(massValue, massUnit, per: volumeValue, volumeUnit)
    }
}
