//
//  IngredientExtensions.swift
//  Frucht
//
//  Created by Feni Brian on 12/07/2022.
//

import Foundation
import SwiftUI

extension Ingredient {
    // Defines how the `Ingredient`'s title should be displayed in card mode.
    struct CardTitle {
        var colour: Color = .black
        var rotation: Angle = .degrees(0)
        var offset: CGSize = .zero
        var blendMode: BlendMode = .normal
        var opacity: Double = 1
        var fontSize: Double = 1
    }
    // Defines a state from whence the `Ingredient` is to transition while changing between card and thumbnail.
    struct Crop {
        var xOffset: Double = 0
        var yOffset: Double = 0
        var scale: Double = 1
        var offset: CGSize {
            CGSize(width: xOffset, height: yOffset)
        }
    }
    // Defines the `Ingredient`'s image used for backgrounds or thumbnails.
    var image: Image {
        Image("ingredient_\(id)", label: Text(name))
            .renderingMode(.original)
    }
}

extension Ingredient {
    var nutritionFact: NutritionFact? {
        NutritionFact.lookupFoodItem(id, forVolume: .cups(1))
    }
}

//extension Ingredient: Codable {
//    enum Codingkeys: String, CodingKey {
//        case id
//        case name
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Codingkeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Codingkeys.self)
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//    }
//}

// MARK: - All Recipes.

extension Ingredient {
    static let avocado = Ingredient(
        id: "avocado",
        name: String(localized: "Avocado", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: .brown, offset: CGSize(width: 0, height: 20), blendMode: .plusDarker, opacity: 0.4, fontSize: 60)
    )
    static let almondMilk = Ingredient(
        id: "almond-milk",
        name: String(localized: "Almond Milk", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(offset: CGSize(width: 0, height: -140), blendMode: .overlay, fontSize: 40),
        thumbnailCrop: Crop(yOffset: 0, scale: 1)
    )
    static let banana = Ingredient(
        id: "banana",
        name: String(localized: "Banana", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(rotation: Angle.degrees(-30), offset: CGSize(width: 0, height: 0), blendMode: .overlay, fontSize: 70),
        thumbnailCrop: Crop(yOffset: 0, scale: 1)
    )
    static let blueberry = Ingredient(
        id: "blueberry",
        name: String(localized: "Blueberry", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: Color.white, offset: CGSize(width: 0, height: 100), opacity: 0.5, fontSize: 45),
        thumbnailCrop: Crop(yOffset: 0, scale: 2)
    )
    static let carrot = Ingredient(
        id: "carrot",
        name: String(localized: "Carrot", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(rotation: Angle.degrees(-90), offset: CGSize(width: -120, height: 100), blendMode: .plusDarker, opacity: 0.3, fontSize: 70),
        thumbnailCrop: Crop(yOffset: 0, scale: 1.2)
    )
    static let chocolate = Ingredient(
        id: "chocolate",
        name: String(localized: "Chocolate", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: Color.brown, rotation: Angle.degrees(-11), offset: CGSize(width: 0, height: 10), blendMode: .overlay, opacity: 0.8, fontSize: 45),
        thumbnailCrop: Crop(yOffset: 0, scale: 1)
    )
    static let coconut = Ingredient(
        id: "coconut",
        name: String(localized: "Coconut", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: Color.brown, offset: CGSize(width: 40, height: 110), blendMode: .plusDarker, opacity: 0.8, fontSize: 36),
        thumbnailCrop: Crop(scale: 1.5)
    )
    static let kiwi = Ingredient(
        id: "kiwi",
        name: String(localized: "Kiwi", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(offset: CGSize(width: 0, height: 0), blendMode: .overlay, fontSize: 140),
        thumbnailCrop: Crop(scale: 1.1)
    )
    static let lemon = Ingredient(
        id: "lemon",
        name: String(localized: "Lemon", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(rotation: Angle.degrees(-9), offset: CGSize(width: 15, height: 90), blendMode: .overlay, fontSize: 80),
        thumbnailCrop: Crop(scale: 1.1)
    )
    static let mango = Ingredient(
        id: "mango",
        name: String(localized: "Mango", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: Color.orange, offset: CGSize(width: 0, height: 20), blendMode: .plusLighter, fontSize: 70)
    )
    static let orange = Ingredient(
        id: "orange",
        name: String(localized: "Orange", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(rotation: Angle.degrees(-90), offset: CGSize(width: -130, height: -60), blendMode: .overlay, fontSize: 80),
        thumbnailCrop: Crop(yOffset: -15, scale: 2)
    )
    static let papaya = Ingredient(
        id: "papaya",
        name: String(localized: "Papaya", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(offset: CGSize(width: -20, height: 20), blendMode: .overlay, fontSize: 70),
        thumbnailCrop: Crop(scale: 1)
    )
    static let peanutButter = Ingredient(
        id: "peanut-butter",
        name: String(localized: "Peanut Butter", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(offset: CGSize(width: 0, height: 190), blendMode: .overlay, fontSize: 35),
        thumbnailCrop: Crop(yOffset: -20, scale: 1.2)
    )
    static let pineapple = Ingredient(
        id: "pineapple",
        name: String(localized: "Pineapple", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: Color.yellow, offset: CGSize(width: 0, height: 90), blendMode: .plusLighter, opacity: 0.5, fontSize: 55)
    )
    static let raspberry = Ingredient(
        id: "raspberry",
        name: String(localized: "Raspberry", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: Color.pink, blendMode: .plusLighter, fontSize: 50),
        thumbnailCrop: Crop(yOffset: 0, scale: 1.5)
    )
    static let spinach = Ingredient(
        id: "spinach",
        name: String(localized: "Spinach", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(offset: CGSize(width: 0, height: -150), blendMode: .overlay, fontSize: 70),
        thumbnailCrop: Crop(yOffset: 0, scale: 1)
    )
    static let strawberry = Ingredient(
        id: "strawberry",
        name: String(localized: "Strawberry", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: Color.white, offset: CGSize(width: 35, height: -5), blendMode: .softLight, opacity: 0.7, fontSize: 30),
        thumbnailCrop: Crop(scale: 2.5),
        cardCrop: Crop(xOffset: -110, scale: 1.35)
    )
    static let water = Ingredient(
        id: "water",
        name: String(localized: "Water", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(colour: Color.blue, offset: CGSize(width: 0, height: 150), opacity: 0.2, fontSize: 50),
        thumbnailCrop: Crop(yOffset: -10, scale: 1.2)
    )
    static let watermelon = Ingredient(
        id: "watermelon",
        name: String(localized: "Watermelon", table: "Ingredients", comment: "Ingredient name"),
        title: CardTitle(rotation: Angle.degrees(-50), offset: CGSize(width: -80, height: -50), blendMode: .overlay, fontSize: 25),
        thumbnailCrop: Crop(yOffset: -10, scale: 1.2)
    )
}

extension Ingredient {
    static let all: [Ingredient] = [
        .avocado,
        .almondMilk,
        .banana,
        .blueberry,
        .carrot,
        .chocolate,
        .coconut,
        .kiwi,
        .lemon,
        .mango,
        .orange,
        .papaya,
        .peanutButter,
        .pineapple,
        .raspberry,
        .spinach,
        .strawberry,
        .watermelon
    ]
    
    init?(for id: Ingredient.ID) {
        guard let result = Ingredient.all.first(where: { $0.id == id }) else { return nil }
        self = result
    }
}

extension Ingredient {
    func measured(with unit: UnitVolume) -> MeasuredIngredient {
        MeasuredIngredient(self, measurement: Measurement(value: 1, unit: unit))
    }
}

