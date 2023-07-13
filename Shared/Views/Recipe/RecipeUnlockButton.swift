//
//  RecipeUnlockButton.swift
//  Frucht
//
//  Created by Feni Brian on 21/07/2022.
//

import SwiftUI
import StoreKit

/// A button that unlocks all recipes.
struct RecipeUnlockButton: View {
    var product: Product
    var purchaseAction: () -> Void
    @Environment(\.colorScheme) private var colourScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("smoothie_recipes-background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                #if os(iOS)
                .frame(height: 225)
                #else
                .frame(height: 150)
                #endif
                .accessibilityHidden(true)
            bottomBar
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(content: { RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(.quaternary, lineWidth: 0.5) })
        .accessibilityElement(children: .contain)
    }
}

struct RecipeUnlockButton_Previews: PreviewProvider {
    static let availableProduct = RecipeUnlockButton.Product(title: "Unlock All Recipes", description: "Make smoothies at home!", availability: .available(displayPrice: "$4.99"))
    static let unavailableProduct = RecipeUnlockButton.Product(title: "Unlock All Recipes", description: "Loading...", availability: .unavailable)
    
    static var previews: some View {
        Group {
            RecipeUnlockButton(product: availableProduct, purchaseAction: {})
            RecipeUnlockButton(product: unavailableProduct, purchaseAction: {})
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

//MARK: - Extension.

extension RecipeUnlockButton {
    struct Product {
        var title: LocalizedStringKey
        var description: LocalizedStringKey
        var availability: Availability
    }
    
    enum Availability {
        case available(displayPrice: String)
        case unavailable
    }
}

extension RecipeUnlockButton.Product {
    init(for product: StoreKit.Product) {
        title = LocalizedStringKey(product.displayName)
        description = LocalizedStringKey(product.description)
        availability = .available(displayPrice: product.displayPrice)
    }
}

extension RecipeUnlockButton {
    var bottomBar: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                    .bold()
                Text(product.description)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
            Spacer()
            if case let .available(displayPrice) =  product.availability {
                Button (action: purchaseAction, label: { Text(displayPrice) })
                    .buttonStyle(.purchase)
                    .accessibilityLabel(Text("Buy recipe for \(displayPrice)", comment: "Accessibility label for button to buy recipe for a certain price."))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .accessibilityElement(children: .combine)
    }
}
