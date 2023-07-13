//
//  Density.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation

public struct Density {
    public var mass: Measurement<UnitMass>
    public var volume: Measurement<UnitVolume>
    
    public init(_ massAmount: Double, _ massUnit: UnitMass, per volumeAmount: Double, _ volumeUnit: UnitVolume) {
        self.mass = Measurement(value: massAmount, unit: massUnit)
        self.volume = Measurement(value: volumeAmount, unit: volumeUnit)
    }
    
    public init(mass: Measurement<UnitMass>, volume: Measurement<UnitVolume>) {
        self.mass = mass
        self.volume = volume
    }
}
