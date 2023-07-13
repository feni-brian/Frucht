//
//  RecipeView.swift
//  Frucht
//
//  Created by Feni Brian on 21/07/2022.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject private var vm: DataViewModel
    @State private var smoothieCount: Int = 1
    var smoothie: Smoothie
    var backgroundColour: Color {
        #if os(iOS)
        return Color(uiColor: .secondarySystemBackground)
        #else
        return Color(nsColor: .textBackgroundColor)
        #endif
    }
    let shape = RoundedRectangle(cornerRadius: 24, style: .continuous)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                firstContentBlock
                secondContentBlock
            }
            .padding()
            .frame(minWidth: 200, idealWidth: 400, maxWidth: 500)
            .frame(maxWidth: .infinity)
        }
        .background(backgroundColour.ignoresSafeArea())
        .navigationTitle(smoothie.title)
        .toolbar(content: { SmoothieFavouriteButton().environmentObject(vm) })
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(smoothie: .thatIsBerryBananas)
            .environmentObject(DataViewModel())
            .previewLayout(.sizeThatFits)
    }
}

//MARK: - Extension

extension RecipeView {
    var recipeToolBar: some View {
        StepperView(label: "\(smoothieCount) Smoothies", configuration: StepperView.Configuration(increment: 1, minValue: 1, maxValue: 9), value: $smoothieCount)
    }
    
    var firstContentBlock: some View {
        smoothie.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxHeight: 300)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(content: { RoundedRectangle(cornerRadius: 24, style: .continuous).strokeBorder(.quaternary, lineWidth: 0.5) })
            .overlay(alignment: .bottom, content: { recipeToolBar })
    }
    
    var secondContentBlock: some View {
        VStack(alignment: .leading) {
            Text("Ingredients.recipe", tableName: "Ingredients", comment: "Ingredients in a recipe. For languages that have different words for \"Ingredient\" based on semantic context.")
                .font(.title.bold())
                .foregroundStyle(.secondary)
            VStack {
                ForEach(0..<smoothie.measuredIngredients.count, id: \.self) { index in
                    RecipeIngredientRow(measuredIngredient: smoothie.measuredIngredients[index].scaled(by: Double(smoothieCount)))
                        .padding(.horizontal)
                    if index < smoothie.measuredIngredients.count - 1 { Divider() }
                }
            }
            .padding(.vertical)
            .background()
            .clipShape(shape)
            .overlay(content: { shape.strokeBorder(.quaternary, lineWidth: 0.5) })
        }
    }
}
