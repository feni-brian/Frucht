//
//  MeasuredIngredient.swift
//  Frucht
//
//  Created by Feni Brian on 12/07/2022.
//

import Foundation

/*
 A measured ingredient model.
 This is an ingredient with a measurement that informs its nutrition facts.
 */
struct MeasuredIngredient: Identifiable, Codable {
    var id: Ingredient.ID { ingredient.id }
    var ingredient: Ingredient
    var measurement: Measurement<UnitVolume>
    
    init(_ ingredient: Ingredient, measurement: Measurement<UnitVolume>) {
        self.ingredient = ingredient
        self.measurement = measurement
    }
}
