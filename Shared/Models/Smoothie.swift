//
//  Smoothie.swift
//  Frucht
//
//  Created by Feni Brian on 12/07/2022.
//

import Foundation

/*
 A representation of a smoothie :
 – It includes its descriptive information and ingredients (and nutritional facts).
 */
struct Smoothie: Identifiable, Codable {
    var id: String
    var title: String
    var description: AttributedString
    var measuredIngredients: [MeasuredIngredient]
}


