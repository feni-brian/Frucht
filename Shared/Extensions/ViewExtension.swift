//
//  ViewExtension.swift
//  Frucht
//
//  Created by Feni Brian on 13/07/2022.
//

import SwiftUI

extension View {
    func animatableFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableFontModifier(size: size, weight: weight, design: design))
    }
}

