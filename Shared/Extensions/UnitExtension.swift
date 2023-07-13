//
//  UnitExtension.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

extension Unit {
    public var unitIcon: Image {
        if let iconProvider = self as? UnitIconProvider {
            return iconProvider.customUnitIcon
        }
        // Fall back to gauge sf-symbol if no icon is specified.
        return Image(systemName: "gauge")
    }
}

