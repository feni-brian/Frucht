//
//  SmoothieRow.swift
//  Frucht
//
//  Created by Feni Brian on 20/07/2022.
//

import SwiftUI

struct SmoothieRow: View {
    @EnvironmentObject private var vm: DataViewModel
    var smoothie: Smoothie
    var cornerRadius: Double {
        #if os(iOS)
        return 10
        #else
        return 4
        #endif
    }
    var listedIngredients: String {
        guard !smoothie.menuIngredients.isEmpty else { return "" }
        var list = [String]()
        list.append(smoothie.menuIngredients.first?.ingredient.name.localizedCapitalized ?? "")
        list += smoothie.menuIngredients.dropFirst().map { $0.ingredient.name.localizedLowercase }
        return ListFormatter.localizedString(byJoining: list)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            smoothie.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).strokeBorder(.quaternary, lineWidth: 0.5))
                .accessibilityHidden(true)
            
            VStack(alignment: .leading) {
                Text(smoothie.title)
                    .font(.headline)
                Text(listedIngredients)
                    .lineLimit(2)
                    .accessibilityLabel(Text("Ingredients: \(listedIngredients).", comment: "Accessibility label containing the full list of smoothie ingredients"))
                Text(smoothie.energy.formatted(.measurement(width: .wide, usage: .food)))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            
            Spacer(minLength: 0)
        }
        .font(.subheadline)
        .accessibilityElement(children: .combine)
    }
}

struct SmoothieRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmoothieRow(smoothie: .lemonBerry)
            SmoothieRow(smoothie: .thatIsASmore)
        }
        .padding(.horizontal)
        .previewLayout(.sizeThatFits)
        .environmentObject(DataViewModel())
    }
}
