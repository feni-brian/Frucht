//
//  RedeemSmoothieButton.swift
//  Frucht
//
//  Created by Feni Brian on 19/07/2022.
//

import SwiftUI

struct RedeemSmoothieButton: View {
    var action: () -> Void
    var height: Double {
        #if os(macOS)
        return 30
        #else
        return 45
        #endif
    }
    
    var body: some View {
        Button(action: action) {
            Text("Redeem Free Smoothie!", comment: "Button to redeem a free smoothie")
                .font(.headline.bold())
                .frame(height: height)
                .frame(minWidth: 100, maxWidth: 400)
                .foregroundStyle(.white)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .contentShape(Rectangle())
        }
        .buttonStyle(.squishable)
    }
}

struct RedeemSmoothieButton_Previews: PreviewProvider {
    static var previews: some View {
        RedeemSmoothieButton(action: {})
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
