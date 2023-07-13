//
//  FruchtWidgets.swift
//  Frucht
//
//  Created by Feni Brian on 23/07/2022.
//

import WidgetKit
import SwiftUI

/// A bundle of widgets for the Frucht app.
@main
struct FruchtWidgets: WidgetBundle {
    var body: some Widget {
        RewardsCardWidget()
        FeaturedSmoothieWidget()
    }
}
