//
//  Pocket.swift
//  Frucht
//
//  Created by Feni Brian on 21/07/2022.
//

import SwiftUI

struct Pocket: View {
    @EnvironmentObject private var vm: DataViewModel
    @State private var presentingRewards: Bool = true
    
    var body: some View {
        Button(action: { presentingRewards = true }, label: { Label("Rewards", systemImage: "seal") })
            .controlSize(.large)
            .buttonStyle(.capsule)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .sheet(isPresented: $presentingRewards, content: { sheetContent.environmentObject(vm) })
    }
}

struct Pocket_Previews: PreviewProvider {
    static var previews: some View {
        Pocket()
            .environmentObject(DataViewModel())
            .previewLayout(.sizeThatFits)
    }
}

//MARK: - Extension.

extension Pocket {
    var sheetContent: some View {
        RewardsView()
            #if os(iOS)
            .overlay(alignment: .topTrailing) {
                Button(action: { presentingRewards = false }, label: { Text("Done", comment: "Button title to dismiss rewards sheet.") })
                    .font(.body.bold())
                    .keyboardShortcut(.defaultAction)
                    .buttonStyle(.capsule)
                    .padding()
            }
            #else
            .frame(minWidth: 400, maxWidth: 600, minHeight: 400, maxHeight: 600)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { presentingRewards = false }, label: { Text("Done", comment: "Button title to dismiss rewards sheet.") })
                }
            }
            #endif
    }
}
