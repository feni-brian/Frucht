//
//  Nutrition.swift
//  Frucht
//
//  Created by Feni Brian on 11/07/2022.
//

import Foundation
import SwiftUI

// Create a type/kind of nutrition with the proceeding information.
public struct Nutrition: Identifiable {
    public var id: String
    public var name: LocalizedStringKey
    public var measurement: DisplayableMeasurement
    public var indented: Bool = false
}
