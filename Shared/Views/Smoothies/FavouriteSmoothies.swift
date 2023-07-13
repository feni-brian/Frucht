//
//  FavouriteSmoothies.swift
//  Frucht
//
//  Created by Feni Brian on 20/07/2022.
//

import SwiftUI

struct FavouriteSmoothies: View {
    @EnvironmentObject private var vm: DataViewModel
    var favouriteSmoothies: [Smoothie] { vm.favoriteSmoothieIDs.map { Smoothie(for: $0)! } }
    
    var body: some View {
        SmoothieList(smoothies: favouriteSmoothies)
            .overlay {
                if vm.favoriteSmoothieIDs.isEmpty {
                    Text("Add some smoothies to your favourites!", comment: "Placeholder text shown in list of smoothies when no favorite smoothies have been added yet")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background()
                        .ignoresSafeArea()
                }
            }
            .navigationTitle(Text("Favourites", comment: "Title of the 'favorites' app section showing the list of favorite smoothies"))
            .environmentObject(vm)
    }
}

struct FavouriteSmoothies_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteSmoothies()
            .environmentObject(DataViewModel())
    }
}
