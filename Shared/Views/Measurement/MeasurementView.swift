//
//  MeasurementView.swift
//  Frucht
//
//  Created by Feni Brian on 21/07/2022.
//

import SwiftUI

struct MeasurementView: View {
    var measurement: DisplayableMeasurement
    
    var body: some View {
        HStack {
            measurement.unitImage
                .foregroundStyle(.secondary)
            Text(measurement.localisedSummary())
        }
    }
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView(measurement: Measurement(value: 1.5, unit: UnitVolume.cups))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
