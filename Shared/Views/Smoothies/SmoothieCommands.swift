//
//  SmoothieCommands.swift
//  Frucht
//
//  Created by Feni Brian on 19/07/2022.
//

import SwiftUI

struct SmoothieCommands: Commands {
    let vm: DataViewModel
    var body: some Commands {
        CommandMenu(Text("Smoothie", comment: "Menu title for smoothie-related actions")) {
            SmoothieFavouriteButton().environmentObject(vm)
                .keyboardShortcut("+", modifiers: [.option, .command])
        }
    }
}
