//
//  UnitEnergyExtension.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation

/*
 This method returns a Unit with an associated converter, whereas units initialized from a string using the
 `Unit(symbol:)` initializer do not have a converter associated and thereby don't support conversion.
 */
extension UnitEnergy {
    static func fromSymbol(_ symbol: String) -> UnitEnergy {
        switch symbol {
        case "kCal":
            return .kilocalories
        default:
            return UnitEnergy(symbol: symbol)
        }
    }
}
