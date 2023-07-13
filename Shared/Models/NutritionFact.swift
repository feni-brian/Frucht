//
//  NutritionFact.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation

// A representation of the informtion/facts that any kind of nutrition ought to have.
public struct NutritionFact {
    public var identifier: String
    public var localisedFoodItemName: String
    public var referenceMass: Measurement<UnitMass>
    public var density: Density
    public var totalSaturatedFat: Measurement<UnitMass>
    public var totalMonoUnsaturatedFat: Measurement<UnitMass>
    public var totalPolyUnsaturatedFat: Measurement<UnitMass>
    public var totalFat: Measurement<UnitMass> { return totalSaturatedFat + totalMonoUnsaturatedFat + totalPolyUnsaturatedFat }
    public var cholesterol: Measurement<UnitMass>
    public var sodium: Measurement<UnitMass>
    public var totalCarbohydrates: Measurement<UnitMass>
    public var dietaryFibre: Measurement<UnitMass>
    public var sugar: Measurement<UnitMass>
    public var protein: Measurement<UnitMass>
    public var calcium: Measurement<UnitMass>
    public var potassium: Measurement<UnitMass>
    public var vitaminA: Measurement<UnitMass>
    public var vitaminC: Measurement<UnitMass>
    public var iron: Measurement<UnitMass>
}


