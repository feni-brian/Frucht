//
//  DisplayableMeasurementProtocol.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

public protocol DisplayableMeasurement {
    var unitImage: Image { get }
    func localisedSummary(unitStyle: MeasurementFormatter.UnitStyle, unitOptions: MeasurementFormatter.UnitOptions) -> String
}

