//
//  NutritionFactView.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import SwiftUI

struct NutritionFactView: View {
    var nutritionFact: NutritionFact
    
    init(nutritionFact: NutritionFact) {
        self.nutritionFact = nutritionFact.converted(toVolume: .cups(1))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            firstBlock
            Divider()
                .padding(.horizontal, 20)
            secondBlock
        }
    }
}

struct NutritionFactView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["en", "de", "pt"], id: \.self) { lang in
                NutritionFactView(nutritionFact: .banana)
                    .previewLayout(.fixed(width: 300, height: 500))
                    .environment(\.locale, .init(identifier: lang))
            }
        }
    }
}

//MARK: - Extensions.

extension NutritionFactView {
    var firstBlock: some View {
        VStack(alignment: .leading) {
            Text("Nutrition Facts")
                .font(.title2)
                .bold()
            Text("Serving Size 1 Cup")
                .font(.footnote)
            Text(nutritionFact.energy.formatted(.measurement(width: .wide, usage: .food)))
                .fontWeight(.semibold)
                .padding(.top, 10)
        }
        .padding(20)
    }
    
    var secondBlock: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(nutritionFact.nutritions) { nutrition in
                    NutritionRow(nutrition: nutrition)
                        .padding(.vertical, 4)
                        .padding(.leading, nutrition.indented ? 10 : 0)
                    Divider()
                }
            }
            .padding([.bottom, .horizontal], 20)
        }
    }
}

