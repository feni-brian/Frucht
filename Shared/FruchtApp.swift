//
//  FruchtApp.swift
//  Shared
//
//  Created by Feni Brian on 11/07/2022.
//

import SwiftUI

/// The single entry point for the Frucht app on iOS and macOS.
@main
struct FruchtApp: App {
    @StateObject private var vm = DataViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
        .commands {
            SidebarCommands()
            SmoothieCommands(vm: vm)
        }
    }
}
