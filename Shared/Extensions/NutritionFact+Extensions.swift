//
//  NutritionFactExtensions.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

extension NutritionFact {
    public func converted(toVolume newReferenceVolume: Measurement<UnitVolume>) -> NutritionFact {
        let newRefMassInCups = newReferenceVolume.converted(to: .cups).value
        let oldRefMassInCups = referenceMass.convertedToVolume(usingDensity: self.density).value
        let scaleFactor = newRefMassInCups / oldRefMassInCups
        
        return NutritionFact(
            identifier: identifier,
            localisedFoodItemName: localisedFoodItemName,
            referenceMass: referenceMass * scaleFactor,
            density: density,
            totalSaturatedFat: totalSaturatedFat * scaleFactor,
            totalMonoUnsaturatedFat: totalMonoUnsaturatedFat * scaleFactor,
            totalPolyUnsaturatedFat: totalPolyUnsaturatedFat * scaleFactor,
            cholesterol: cholesterol * scaleFactor,
            sodium: sodium * scaleFactor,
            totalCarbohydrates: totalCarbohydrates * scaleFactor,
            dietaryFibre: dietaryFibre * scaleFactor,
            sugar: sugar * scaleFactor,
            protein: protein * scaleFactor,
            calcium: calcium * scaleFactor,
            potassium: potassium * scaleFactor,
            vitaminA: vitaminA * scaleFactor,
            vitaminC: vitaminC * scaleFactor,
            iron: iron * scaleFactor
        )
    }
    
    public func converted(toMass newReferenceMass: Measurement<UnitMass>) -> NutritionFact {
        let newRefMassInGrams = newReferenceMass.converted(to: .grams).value
        let oldRefMassInGrams = referenceMass.converted(to: .grams).value
        let scaleFactor = newRefMassInGrams / oldRefMassInGrams
        
        return NutritionFact(
            identifier: identifier,
            localisedFoodItemName: localisedFoodItemName,
            referenceMass: referenceMass * scaleFactor,
            density: density,
            totalSaturatedFat: totalSaturatedFat * scaleFactor,
            totalMonoUnsaturatedFat: totalMonoUnsaturatedFat * scaleFactor,
            totalPolyUnsaturatedFat: totalPolyUnsaturatedFat * scaleFactor,
            cholesterol: cholesterol * scaleFactor,
            sodium: sodium * scaleFactor,
            totalCarbohydrates: totalCarbohydrates * scaleFactor,
            dietaryFibre: dietaryFibre * scaleFactor,
            sugar: sugar * scaleFactor,
            protein: protein * scaleFactor,
            calcium: calcium * scaleFactor,
            potassium: potassium * scaleFactor,
            vitaminA: vitaminA * scaleFactor,
            vitaminC: vitaminC * scaleFactor,
            iron: iron * scaleFactor
        )
    }
    
    public func amount(_ mass: Measurement<UnitMass>) -> NutritionFact {
        return converted(toMass: mass)
    }
    
    public func amount(_ volume: Measurement<UnitVolume>) -> NutritionFact {
        // Convert volume to mass via density
        let mass = volume.convertedToMass(usingDensity: density)
        return converted(toMass: mass)
    }
}

extension NutritionFact: Codable {
    enum CodingKeys: String, CodingKey {
        case identifier
        case localisedFoodItemName
        case referenceMass
        case density
        case totalSaturatedFat
        case totalMonoUnsaturatedFat
        case totalPolyUnsaturatedFat
        case cholesterol
        case sodium
        case totalCarbohydrates
        case dietaryFibre
        case sugar
        case protein
        case calcium
        case potassium
        case vitaminA
        case vitaminC
        case iron
    }
    
    public func encode(to encoder: Encoder) throws {
        // Add code here
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let densityString = try values.decode(String.self, forKey: .density)
        
        identifier = try values.decode(String.self, forKey: .identifier)
        localisedFoodItemName = try values.decode(String.self, forKey: .localisedFoodItemName)
        density = Density.fromString(densityString)
        referenceMass = try values.decode(Measurement<UnitMass>.self, forKey: .referenceMass)
        totalSaturatedFat = try values.decode(Measurement<UnitMass>.self, forKey: .totalSaturatedFat)
        totalMonoUnsaturatedFat = try values.decode(Measurement<UnitMass>.self, forKey: .totalMonoUnsaturatedFat)
        totalPolyUnsaturatedFat = try values.decode(Measurement<UnitMass>.self, forKey: .totalPolyUnsaturatedFat)
        cholesterol = try values.decode(Measurement<UnitMass>.self, forKey: .cholesterol)
        sodium = try values.decode(Measurement<UnitMass>.self, forKey: .sodium)
        totalCarbohydrates = try values.decode(Measurement<UnitMass>.self, forKey: .totalCarbohydrates)
        dietaryFibre = try values.decode(Measurement<UnitMass>.self, forKey: .dietaryFibre)
        sugar = try values.decode(Measurement<UnitMass>.self, forKey: .sugar)
        protein = try values.decode(Measurement<UnitMass>.self, forKey: .protein)
        calcium = try values.decode(Measurement<UnitMass>.self, forKey: .calcium)
        potassium = try values.decode(Measurement<UnitMass>.self, forKey: .potassium)
        vitaminA = try values.decode(Measurement<UnitMass>.self, forKey: .vitaminA)
        vitaminC = try values.decode(Measurement<UnitMass>.self, forKey: .vitaminC)
        iron = try values.decode(Measurement<UnitMass>.self, forKey: .iron)
    }
}

extension NutritionFact {
    // Nutritional information is as per 100 grams, unless a `mass` is specified.
    public static func lookupFoodItem(_ foodItemIdentifier: String, forMass mass: Measurement<UnitMass> = Measurement(value: 100, unit: .grams)) -> NutritionFact? {
        return nutritionFacts[foodItemIdentifier]?.converted(toMass: mass)
    }
    
    // Nutritional information is as per cup, unless a `volume` is specified.
    public static func lookupFoodItem(_ foodItemIdentifier: String, forVolume volume: Measurement<UnitVolume> = Measurement(value: 1, unit: .cups)) -> NutritionFact? {
        guard let nutritionFact = nutritionFacts[foodItemIdentifier] else { return nil }
        let mass = volume.convertedToMass(usingDensity: nutritionFact.density)
        return nutritionFact.converted(toMass: mass)
    }
    
    // MARK: Examples
    public static var banana: NutritionFact { nutritionFacts["banana"]! }
    public static var blueberry: NutritionFact { nutritionFacts["blueberry"]! }
    public static var peanutButter: NutritionFact { nutritionFacts["peanut-butter"]! }
    public static var almondMilk: NutritionFact { nutritionFacts["almond-milk"]! }
    
    public static var zero: NutritionFact {
        NutritionFact(
            identifier: "",
            localisedFoodItemName: "",
            referenceMass: .grams(0),
            density: Density(mass: .grams(1), volume: .cups(1)),
            totalSaturatedFat: .grams(0),
            totalMonoUnsaturatedFat: .grams(0),
            totalPolyUnsaturatedFat: .grams(0),
            cholesterol: .grams(0),
            sodium: .grams(0),
            totalCarbohydrates: .grams(0),
            dietaryFibre: .grams(0),
            sugar: .grams(0),
            protein: .grams(0),
            calcium: .grams(0),
            potassium: .grams(0),
            vitaminA: .grams(0),
            vitaminC: .grams(0),
            iron: .grams(0)
        )
    }
}

extension NutritionFact {
    // Support adding up nutritional facts.
    public static func + (lhs: NutritionFact, rhs: NutritionFact) -> NutritionFact {
        // Calculate the combined mass, volume, and density.
        let totalMass = lhs.referenceMass + rhs.referenceMass
        let lhsVolume = lhs.referenceMass.convertedToVolume(usingDensity: lhs.density)
        let rhsVolume = rhs.referenceMass.convertedToVolume(usingDensity: rhs.density)
        let totalVolume = lhsVolume + rhsVolume
        
        return NutritionFact(
            identifier: "",
            localisedFoodItemName: "",
            referenceMass: totalMass,
            density: Density(mass: totalMass, volume: totalVolume),
            totalSaturatedFat: lhs.totalSaturatedFat + rhs.totalSaturatedFat,
            totalMonoUnsaturatedFat: lhs.totalMonoUnsaturatedFat + rhs.totalMonoUnsaturatedFat,
            totalPolyUnsaturatedFat: lhs.totalPolyUnsaturatedFat + rhs.totalPolyUnsaturatedFat,
            cholesterol: lhs.cholesterol + rhs.cholesterol,
            sodium: lhs.sodium + rhs.sodium,
            totalCarbohydrates: lhs.totalCarbohydrates + rhs.totalCarbohydrates,
            dietaryFibre: lhs.dietaryFibre + rhs.dietaryFibre,
            sugar: lhs.sugar + rhs.sugar,
            protein: lhs.protein + rhs.protein,
            calcium: lhs.calcium + rhs.calcium,
            potassium: lhs.potassium + rhs.potassium,
            vitaminA: lhs.vitaminA + rhs.vitaminA,
            vitaminC: lhs.vitaminC + rhs.vitaminC,
            iron: lhs.iron + rhs.iron
        )
    }
}

extension NutritionFact: CustomStringConvertible {
    public var description: String {
        let suffix = identifier.isEmpty ? "" : " of \(identifier)"
        return "\(referenceMass.converted(to: .grams).localisedSummary(unitStyle: .medium))" + suffix
    }
}

extension NutritionFact {
    public var nutritions: [Nutrition] {
        [
            Nutrition(id: "totalFat", name: "Total Fat", measurement: totalFat),
            Nutrition(id: "totalSaturatedFat", name: "Total Saturated Fat", measurement: totalSaturatedFat, indented: true),
            Nutrition(id: "totalMonoUnsaturatedFat", name: "Total Mono-Unsaturated Fat", measurement: totalMonoUnsaturatedFat, indented: true),
            Nutrition(id: "totalPolyUnsaturatedFat", name: "Total Poly-Unsaturated Fat", measurement: totalPolyUnsaturatedFat, indented: true),
            Nutrition(id: "cholesterol", name: "Cholesterol", measurement: cholesterol),
            Nutrition(id: "sodium", name: "Sodium", measurement: sodium),
            Nutrition(id: "totalCarbohydrates", name: "Total Carbohydrates", measurement: totalCarbohydrates),
            Nutrition(id: "dietaryFibre", name: "Dietary Fibre", measurement: dietaryFibre, indented: true),
            Nutrition(id: "sugar", name: "Sugar", measurement: sugar, indented: true),
            Nutrition(id: "protein", name: "Protein", measurement: protein),
            Nutrition(id: "calcium", name: "Calcium", measurement: calcium),
            Nutrition(id: "potassium", name: "Potassium", measurement: potassium),
            Nutrition(id: "vitaminA", name: "Vitamin A", measurement: vitaminA),
            Nutrition(id: "vitaminC", name: "Vitamin C", measurement: vitaminC),
            Nutrition(id: "iron", name: "Iron", measurement: iron)
        ]
    }
}

extension NutritionFact {
    public var kilocaloriesFromFat: Double { totalFat.converted(to: .grams).value * kilocaloriesInFat }
    public var kilocaloriesFromProtein: Double { protein.converted(to: .grams).value * kilocaloriesInProtein }
    public var kilocaloriesFromCarbohydrates: Double { (totalCarbohydrates - dietaryFibre).converted(to: .grams).value * kilocaloriesInCarbohydrate }
    public var kilocalories: Double { kilocaloriesFromFat + kilocaloriesFromProtein + kilocaloriesFromCarbohydrates }
    public var energy: Measurement<UnitEnergy> { return Measurement<UnitEnergy>(value: kilocalories, unit: .kilocalories) }
    
    public var calorieBreakdown: CalorieBreakdown {
        let totalKilocalories = kilocalories
        let percentageFat = kilocaloriesFromFat / totalKilocalories * 100
        let percentageProtein = kilocaloriesFromProtein / totalKilocalories * 100
        let percentageCarbohydrate = kilocaloriesFromCarbohydrates / totalKilocalories * 100
        return CalorieBreakdown(percentFat: percentageFat, percentProtein: percentageProtein, percentCarbohydrate: percentageCarbohydrate)
    }
}

