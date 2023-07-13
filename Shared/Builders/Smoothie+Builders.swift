//
//  Smoothie+Builders.swift
//  Frucht
//
//  Created by Feni Brian on 12/07/2022.
//

import Foundation


@resultBuilder
enum SmoothieBuilder {
    static func buildBlock(_ description: AttributedString, _ ingredients: MeasuredIngredient...) -> (AttributedString, [MeasuredIngredient]) {
        return (description, ingredients)
    }
    
    @available(*, unavailable, message: "First statement of SmoothieBuilder must be its descriptive string!")
    static func buildBlock(_ ingredients: MeasuredIngredient...) -> (String, [MeasuredIngredient]) {
        fatalError()
    }
}

@resultBuilder
enum SmoothieArrayBuilder {
    static func buildEither(first component: [Smoothie]) -> [Smoothie] {
        return component
    }
    static func buildEither(second component: [Smoothie]) -> [Smoothie] {
        return component
    }
    static func buildOptional(_ component: [Smoothie]?) -> [Smoothie] {
        return component ?? []
    }
    static func buildExpression(_ expression: Smoothie) -> [Smoothie] {
        return [expression]
    }
    static func buildExpression(_ expression: ()) -> [Smoothie] {
        return []
    }
    static func buildBlock(_ smoothies: [Smoothie]...) -> [Smoothie] {
        return smoothies.flatMap { $0 }
    }
}
