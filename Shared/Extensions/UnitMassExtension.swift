//
//  UnitMassExtension.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

/*
 This method returns a Unit with an associated converter, whereas units initialized from a string using the
 `Unit(symbol:)` initializer do not have a converter associated and thereby don't support conversion.
 */
extension UnitMass {
    static func fromSymbol(_ symbol: String) -> UnitMass {
        switch symbol {
        case "kg":
            return .kilograms
        case "g":
            return .grams
        case "mg":
            return .milligrams
        default:
            return UnitMass(symbol: symbol)
        }
    }
}

// By subscribing to the UnitIconProviderProtocol, we can thus provide our preferred icons.
extension UnitMass: UnitIconProvider {
    var customUnitIcon: Image {
        Image(systemName: "scalemass.fill")
    }
}
