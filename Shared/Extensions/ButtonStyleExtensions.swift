//
//  ButtonStyleExtensions.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import Foundation
import SwiftUI

//MARK: - For SquishableButtonStyle
extension ButtonStyle where Self == SquishableButtonStyle {
    static var squishable: SquishableButtonStyle {
        SquishableButtonStyle()
    }
    
    static func squishable(fadeOnPress: Bool = true) -> SquishableButtonStyle {
        SquishableButtonStyle(fadeOnPress: fadeOnPress)
    }
}

//MARK: - For CapsuleButtonStyle
extension ButtonStyle where Self == CapsuleButtonStyle {
    static var capsule: CapsuleButtonStyle {
        CapsuleButtonStyle()
    }
}

//MARK: - For PurchaseButtonStyle
extension ButtonStyle where Self == PurchaseButtonStyle {
    static var purchase: PurchaseButtonStyle {
        PurchaseButtonStyle()
    }
}

