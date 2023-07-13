//
//  CountButton.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import SwiftUI

struct CountButton: View {
    @Environment(\.isEnabled) var isEnabled
    var mode: Mode
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: mode.imageName)
                .symbolVariant(isEnabled ? .circle.fill : .circle)
                .imageScale(.large)
                .padding()
                .contentShape(Rectangle())
                .opacity(0.5)
        }
        .buttonStyle(.plain)
    }
}

struct CountButton_Previews: PreviewProvider {
    static var previews: some View {
        CountButton(mode: .increment, action: {})
    }
}

//MARK: - Extension.
extension CountButton {
    enum Mode {
        case increment
        case decrement
        
        var imageName: String {
            switch self {
            case .increment:
                return "plus"
            case .decrement:
                return "minus"
            }
        }
    }
}
