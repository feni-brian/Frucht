//
//  PurchaseButtonStyle.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import Foundation
import SwiftUI

struct PurchaseButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colourScheme
    var foregroundColour: Color { colourScheme == .dark ? .black : .white }
    var backgroundColour: Color { colourScheme == .dark ? .white : .black }
    var minWidth: Double {
        #if os(iOS)
        return 80
        #else
        return 60
        #endif
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.bold())
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .contentShape(Capsule())
    }
}
