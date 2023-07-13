//
//  CalorieBreakdown.swift
//  Frucht
//
//  Created by Feni Brian on 12/07/2022.
//

import Foundation
import SwiftUI

/*
 A representation of the breakdown of the calories in fat, carbohydrates, and protein.
 • Calories are a unit of measurement that show how much energy a food item will provide to your body.
 • The more calories a food has, the more energy it can provide to your body.
 • There a generally six ingredients the body requires to stay healthy.
 • Of these six nutrients, carbohydrates, protein and fats provide calories.
 • Each gram of carbohydrate and protein yields 4 calories.
 • Each gram of fat yields 9 calories.
 */

private(set) var kilocaloriesInFat: Double = 9
private(set) var kilocaloriesInProtein: Double = 4
private(set) var kilocaloriesInCarbohydrate: Double = 4

public struct CalorieBreakdown {
    public let percentFat: Double
    public let percentProtein: Double
    public let percentCarbohydrate: Double
    
    public var labeledValues: [(String, Double)] {
        return [
            ("Fat", percentFat),
            ("Protein", percentProtein),
            ("Carbohydrate", percentCarbohydrate)
        ]
    }
}

