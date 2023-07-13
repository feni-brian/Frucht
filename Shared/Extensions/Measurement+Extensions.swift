//
//  MeasurementExtensions.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

extension Measurement: DisplayableMeasurement {
    public func localisedSummary(unitStyle: Formatter.UnitStyle = .long, unitOptions: MeasurementFormatter.UnitOptions = [.providedUnit]) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = unitStyle
        formatter.unitOptions = unitOptions
        return formatter.string(from: self)
    }
    
    public var unitImage: Image {
        unit.unitIcon
    }
}

extension Measurement where UnitType == UnitMass {
    init(string: String) {
        let components = string.split(separator: " ")
        let valueString = String(components[0])
        let unitSymbolString = String(components[1])
        self.init(value: Double(valueString)!, unit: UnitMass.fromSymbol(unitSymbolString))
    }
}

extension Measurement where UnitType == UnitVolume {
    init(string: String) {
        let components = string.split(separator: " ")
        let valueString = String(components[0])
        let unitSymbolString = String(components[1])
        self.init(value: Double(valueString)!, unit: UnitVolume.fromSymbol(unitSymbolString))
    }
}

// MARK: - Volume to Mass conversion and vice-versa

extension Measurement where UnitType == UnitVolume {
    public func convertedToMass(usingDensity density: Density) -> Measurement<UnitMass> {
        let densityLitres = density.volume.converted(to: .liters).value
        let litres = converted(to: .liters).value
        let scale = litres / densityLitres
        return density.mass * scale
    }
}

extension Measurement where UnitType == UnitMass {
    public func convertedToVolume(usingDensity density: Density) -> Measurement<UnitVolume> {
        let densityKilos = density.mass.converted(to: .kilograms).value
        let kilos = converted(to: .kilograms).value
        let scale = kilos / densityKilos
        return density.volume * scale
    }
}

// MARK: - Convience accessors

extension Measurement where UnitType == UnitVolume {
    public static func cups(_ cups: Double) -> Measurement<UnitVolume> {
        return Measurement(value: cups, unit: .cups)
    }
    public static func tablespoons(_ tablespoons: Double) -> Measurement<UnitVolume> {
        return Measurement(value: tablespoons, unit: .tablespoons)
    }
}

extension Measurement where UnitType == UnitMass {
    public static func grams(_ grams: Double) -> Measurement<UnitMass> {
        return Measurement(value: grams, unit: .grams)
    }
}

