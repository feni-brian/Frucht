//
//  AnimatableFontModifier.swift
//  Frucht
//
//  Created by Feni Brian on 13/07/2022.
//

import Foundation
import SwiftUI

// This is a modifier that animates a font's size that changes over time.
struct AnimatableFontModifier: Animatable, ViewModifier {
    var size: Double
    var weight: Font.Weight = .regular
    var design: Font.Design = .default
    
    var animatableData: Double {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

