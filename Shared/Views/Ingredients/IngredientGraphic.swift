//
//  IngredientGraphic.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import SwiftUI

struct IngredientGraphic: View {
    var ingredient: Ingredient
    var style: Style
    var closeAction: () -> Void = {}
    var flipAction: () -> Void = {}
    var displayingAsCard: Bool { style == .cardFront || style == .cardBack }
    var shape = RoundedRectangle(cornerRadius: 16, style: .continuous)
    
    var body: some View {
        ZStack {
            image
            if style != .cardBack {
                title
            }
            if style == .cardFront {
                cardControls(for: .front)
                    .foregroundStyle(ingredient.title.colour)
                    .opacity(ingredient.title.opacity)
                    .blendMode(ingredient.title.blendMode)
            }
            if style == .cardBack {
                ZStack {
                    if let nutrientFact = ingredient.nutritionFact {
                        NutritionFactView(nutritionFact: nutrientFact)
                            .padding(.bottom, 70)
                    }
                    cardControls(for: .back)
                }
                .background(.thinMaterial)
            }
        }
        .frame(minWidth: 130, maxWidth: 400, maxHeight: 500)
        .compositingGroup()
        .clipShape(shape)
        .overlay {
            shape
                .inset(by: 0.5)
                .stroke(.quaternary, lineWidth: 0.5)
        }
        .contentShape(shape)
        .accessibilityElement(children: .contain)
    }
}

struct IngredientGraphic_Previews: PreviewProvider {
    static let ingredient: Ingredient = .orange
    
    static var previews: some View {
        Group {
            IngredientGraphic(ingredient: ingredient, style: .thumbnail)
                .frame(width: 180, height: 180)
                .previewDisplayName("Thumbnail")
            IngredientGraphic(ingredient: ingredient, style: .cardFront)
                .aspectRatio(0.75, contentMode: .fit)
                .frame(width: 500, height: 600)
                .previewDisplayName("Card Front")
            IngredientGraphic(ingredient: ingredient, style: .cardBack)
                .aspectRatio(0.75, contentMode: .fit)
                .frame(width: 500, height: 600)
                .previewDisplayName("Card Back")
        }
        .previewLayout(.sizeThatFits)
    }
}

//MARK: - Extensions.
extension IngredientGraphic {
    var image: some View {
        GeometryReader { geometry in
            ingredient.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .scaleEffect(displayingAsCard ? ingredient.cardCrop.scale : ingredient.thumbnailCrop.scale)
                .offset(displayingAsCard ? ingredient.cardCrop.offset : ingredient.thumbnailCrop.offset)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .scaleEffect(x: style == .cardBack ? -1 : 1)
        }
        .accessibilityHidden(true)
    }
    
    var title: some View {
        Text(ingredient.name.uppercased())
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .foregroundStyle(ingredient.title.colour)
            .rotationEffect(displayingAsCard ? ingredient.title.rotation : .degrees(0))
            .opacity(ingredient.title.opacity)
            .blendMode(ingredient.title.blendMode)
            .animatableFont(size: displayingAsCard ? ingredient.title.fontSize : 40, weight: .bold)
            .minimumScaleFactor(0.25)
            .offset(displayingAsCard ? ingredient.title.offset : .zero)
    }
    
    func cardControls(for side: FlipViewSide) -> some View {
        VStack {
            if side == .front {
                CardActionButton(label: "Close", systemImage: "xmark.circle.fill", action: closeAction)
                    .scaleEffect(displayingAsCard ? 1 : 0.5)
                    .opacity(displayingAsCard ? 1 : 0)
            }
            Spacer()
            CardActionButton(label: side == .front ? "Open Nutrition Facts" : "Close Nutrition Facts", systemImage: side == .front ? "info.circle.fill" : "arrow.left.circle.fill", action: flipAction)
                .scaleEffect(displayingAsCard ? 1 : 0.5)
                .opacity(displayingAsCard ? 1 : 0)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    enum Style {
        case cardFront
        case cardBack
        case thumbnail
    }
}
