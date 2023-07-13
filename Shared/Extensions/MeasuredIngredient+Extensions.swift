//
//  MeasuredIngredient+Extensions.swift
//  Frucht
//
//  Created by Feni Brian on 13/07/2022.
//

import Foundation

extension MeasuredIngredient {
    var kilocalories: Int {
        guard let nutritionFact = nutritionFact else { return 0 }
        return Int(nutritionFact.kilocalories)
    }
    // Nutritional information according to the quantity of this measurement.
    var nutritionFact: NutritionFact? {
        guard let nutritionFact = ingredient.nutritionFact else { return nil }
        let mass = measurement.convertedToMass(usingDensity: nutritionFact.density)
        return nutritionFact.converted(toMass: mass)
    }
}

extension MeasuredIngredient {
    func scaled(by scale: Double) -> MeasuredIngredient {
        return MeasuredIngredient(ingredient, measurement: measurement * scale)
    }
}
