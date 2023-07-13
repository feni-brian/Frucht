//
//  Ingredient.swift
//  Frucht
//
//  Created by Feni Brian on 12/07/2022.
//

import Foundation

// A representation of a smoothie ingredient and its appearance as a thumbnail and card.
struct Ingredient: Identifiable, Codable {
    var id: String
    var name: String
    var title = CardTitle()
    var thumbnailCrop = Crop()
    var cardCrop = Crop()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
