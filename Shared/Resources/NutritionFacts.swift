//
//  NutritionFacts.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

/*
 This loads nutritional information for each item in the json data.
 */

//let nutritionFacts: [String: NutritionFact] = {
//    if let jsonUrl = Bundle.main.url(forResource: "NutritionalItems", withExtension: "json"),
//       let jsonData = try? Data(contentsOf: jsonUrl),
//       let facts = try? JSONDecoder().decode(Dictionary<String, NutritionFact>.self, from: jsonData) {
//        return facts
//    } else {
//        return [String: NutritionFact]()
//    }
//
//    let file = "NutritionItems"
//    guard let jsonUrl = Bundle.main.url(forResource: file, withExtension: "json") else { fatalError("Failed to locate \(file) in bundle!") }
//    guard let jsonData = try? Data(contentsOf: jsonUrl) else { fatalError("Failed to load \(file) from bundle!") }
//    guard let facts = try? JSONDecoder().decode(Dictionary<String, NutritionFact>.self, from: jsonData) else { fatalError("Failed to decode \(file) from bundle!") }
//    return facts
//}()

let nutritionFacts: [String : NutritionFact] = Bundle.main.decode(from: "NutritionItems")

