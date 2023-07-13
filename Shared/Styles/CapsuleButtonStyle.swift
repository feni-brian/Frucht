//
//  CapsuleButtonStyle.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import Foundation
import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .dynamicTypeSize(.large)
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(in: Capsule())
            .foregroundColor(Color.accentColor)
            .contentShape(Capsule())
            #if os(iOS)
            .hoverEffect(.lift)
            #endif
    }
}
