//
//  FlipModifier.swift
//  Frucht
//
//  Created by Feni Brian on 13/07/2022.
//

import Foundation
import SwiftUI

//MARK: - FlipModifier
struct FlipModifier: Animatable, ViewModifier {
    var side: FlipViewSide
    var flipProgress: Double
    var animatableData: Double {
        get { flipProgress }
        set { flipProgress = newValue }
    }
    var visible: Bool {
        switch side {
        case .front:
            return flipProgress <= 0.5
        case .back:
            return flipProgress > 5
        }
    }
    var scale: CGFloat {
        switch side {
        case .front:
            return 1.0
        case .back:
            return -1.0
        }
    }
    
    init(side: FlipViewSide, visibleSide: FlipViewSide) {
        self.side = side
        self.flipProgress = visibleSide == .front ? 0 : 1
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .opacity(visible ? 1 : 0)
                .accessibilityHidden(!visible)
        }
        .scaleEffect(x: scale, y: 1.0)
        .rotation3DEffect(.degrees(flipProgress * -180), axis: (x: 0.0, y: 1.0, z: 0.0), perspective: 0.5)
    }
}

//MARK: - FlipViewSide
// This simply flips an smoothie card from front to back and vice-versa.
enum FlipViewSide {
    case front
    case back
    
    mutating func toggle() {
        self = self == .front ? .back : .front
    }
}


