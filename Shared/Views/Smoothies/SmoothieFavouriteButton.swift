//
//  SmoothieFavouriteButton.swift
//  Frucht
//
//  Created by Feni Brian on 19/07/2022.
//

import SwiftUI

struct SmoothieFavouriteButton: View {
    @EnvironmentObject private var vm: DataViewModel
    var isFavourite: Bool {
        guard let smoothieID = vm.selectedSmoothieID else { return false }
        return vm.favoriteSmoothieIDs.contains(smoothieID)
    }
    
    var body: some View {
        Button(action: toggleFavourite) {
            if isFavourite {
                Label(title: { Text("Remove From Favourites", comment: "Toolbar button/menu item to remove a smoothie from favourites") }, icon: { Image(systemName: "heart.fill") })
            } else {
                Label(title: { Text("Add to Favourites", comment: "Toolbar button/menu item to add a smoothie to favourites") }, icon: { Image(systemName: "heart") })
            }
        }
        .disabled(vm.selectedSmoothieID == nil)
    }
    
    fileprivate func toggleFavourite() {
        guard let smoothieID = vm.selectedSmoothieID else { return }
        vm.toggleFavorite(smoothieID: smoothieID)
    }
}

struct SmoothieFavouriteButton_Previews: PreviewProvider {
    static var previews: some View {
        SmoothieFavouriteButton()
            .padding()
            .previewLayout(.sizeThatFits)
            .environmentObject(DataViewModel())
    }
}
