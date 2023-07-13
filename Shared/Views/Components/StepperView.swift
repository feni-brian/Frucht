//
//  StepperView.swift
//  Frucht
//
//  Created by Feni Brian on 16/07/2022.
//

import SwiftUI

struct StepperView: View {
    var label: LocalizedStringKey
    var configuration: Configuration
    @State private var tilt: Double = 0.0
    @Binding var value: Int {
        didSet {
            tilt = value > oldValue ? 1 : -1
            withAnimation(.interactiveSpring(response: 1, dampingFraction: 1)) { tilt = 0 }
        }
    }
    
    var body: some View {
        HStack {
            CountButton(mode: .decrement, action: decrement)
                .disabled(value <= configuration.minValue)
            Text(label)
                .frame(width: 150)
                .padding(.vertical)
            CountButton(mode: .increment, action: increment)
                .disabled(configuration.maxValue <= value)
        }
        .accessibilityRepresentation { stepper }
        .font(Font.title2.bold())
        .foregroundStyle(.primary)
        .background(.thinMaterial, in: Capsule())
        .contentShape(Capsule())
        .rotation3DEffect(.degrees(3 * tilt), axis: (x: 0, y: 1, z: 0))
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(label: "Stepper", configuration: StepperView.Configuration(increment: 1, minValue: 1, maxValue: 10), value: .constant(5))
            .padding()
    }
}

//MARK: - Extension.

extension StepperView {
    var stepper: some View {
        Stepper("Smoothie Count", value: $value, in: configuration.minValue...configuration.maxValue, step: configuration.increment)
    }
    
    func increment() {
        value = min(max(value + configuration.increment, configuration.minValue), configuration.maxValue)
    }
    func decrement() {
        value = min(max(value - configuration.increment, configuration.minValue), configuration.maxValue)
    }
    
    struct Configuration {
        var increment: Int
        var minValue: Int
        var maxValue: Int
    }
}
