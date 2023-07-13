//
//  UnitIconProviderProtocol.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

// Allows Unit subclasses to provide icon overrides.
protocol UnitIconProvider {
    var customUnitIcon: Image { get }
}

