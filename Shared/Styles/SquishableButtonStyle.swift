//
//  SquishableButtonStyle.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import SwiftUI
import Foundation

struct SquishableButtonStyle: ButtonStyle {
    var fadeOnPress = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed && fadeOnPress ? 0.75 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
