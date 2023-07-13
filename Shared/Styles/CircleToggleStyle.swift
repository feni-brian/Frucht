//
//  CircleToggleStyle.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import Foundation
import SwiftUI

struct CircleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label.hidden()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .accessibilityLabel(configuration.isOn ? Text("Checked", comment: "Accessibility label for circular style toggle that is checked (on)") : Text("Unchecked", comment: "Accessibility label for circular style toggle that is unchecked (off)"))
                .foregroundStyle(configuration.isOn ? Color.accentColor : .secondary)
                .imageScale(.large)
                .font(.title)
        }
    }
}
