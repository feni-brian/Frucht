//
//  DisplayableMeasurementExtension.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

extension DisplayableMeasurement {
    public func localisedSummary() -> String {
        localisedSummary(unitStyle: .long, unitOptions: [.providedUnit])
    }
}

