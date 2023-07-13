//
//  UnitVolumeExtension.swift
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
extension UnitVolume {
    static func fromSymbol(_ symbol: String) -> UnitVolume {
        switch symbol {
        case "gal":
            return .gallons
        case "cup":
            return .cups
        default:
            return UnitVolume(symbol: symbol)
        }
    }
}

// By subscribing to the UnitIconProviderProtocol, we can thus provide our preferred icons.
extension UnitVolume: UnitIconProvider {
    var customUnitIcon: Image {
        switch symbol {
        case "cup", "qt", "tbsp", "tsp", "gal":
            return Image(symbol)
        default:
            return Image(systemName: "drop.fill")
        }
    }
}
