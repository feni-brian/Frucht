//
//  RecipeIngredientRow.swift
//  Frucht
//
//  Created by Feni Brian on 21/07/2022.
//

import SwiftUI

struct RecipeIngredientRow: View {
    var measuredIngredient: MeasuredIngredient
    @State private var checked: Bool = false
    
    var body: some View {
        Button(action: { checked.toggle() }) {
            HStack {
                measuredIngredient.ingredient.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(measuredIngredient.ingredient.thumbnailCrop.scale * 1.25)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                VStack(alignment: .leading, spacing: 4) {
                    Text(measuredIngredient.ingredient.name)
                        .font(.headline)
                    MeasurementView(measurement: measuredIngredient.measurement)
                }
                Spacer()
                Toggle(isOn: $checked) {
                    Text("Complete", comment: "Label for toggle showing whether you have completed adding an ingredient that's part of a smoothie recipe")
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .toggleStyle(.circle)
    }
}

struct RecipeIngredientRow_Previews: PreviewProvider {
    static let measuredIngredient: MeasuredIngredient = .init(Ingredient.almondMilk, measurement: .cups(1))
    
    static var previews: some View {
        RecipeIngredientRow(measuredIngredient: measuredIngredient)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
