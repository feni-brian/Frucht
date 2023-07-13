//
//  NutritionRow.swift
//  Frucht
//
//  Created by Feni Brian on 17/07/2022.
//

import SwiftUI

public struct NutritionRow: View {
    public var nutrition: Nutrition
    var nutritionValue: String { nutrition.measurement.localisedSummary(unitStyle: .short, unitOptions: .providedUnit) }
    
    public init(nutrition: Nutrition) {
        self.nutrition = nutrition
    }
    
    public var body: some View {
        HStack {
            Text(nutrition.name)
            Spacer()
            Text(nutritionValue)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
        .font(.footnote)
    }
}

struct NutritionRow_Previews: PreviewProvider {
    static var previews: some View {
        let nutrition: Nutrition = .init(id: "iron", name: "Iron", measurement: Measurement(value: 25, unit: UnitMass.milligrams))
        
        return NutritionRow(nutrition: nutrition)
            .previewLayout(.sizeThatFits)
    }
}
