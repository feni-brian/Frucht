//
//  AppSideBarNavigation.swift
//  Frucht
//
//  Created by Feni Brian on 21/07/2022.
//

import SwiftUI

struct AppSideBarNavigation: View {
    @EnvironmentObject private var vm: DataViewModel
    @State private var presentingRewards: Bool = false
    @State private var selection: NavigationItem? = .menu
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(tag: NavigationItem.menu, selection: $selection, destination: { SmoothieMenu() }) {
                    Label("Menu", systemImage: "list.bullet")
                }
                NavigationLink(tag: NavigationItem.favourites, selection: $selection, destination: { FavouriteSmoothies() }) {
                    Label("Favourites", systemImage: "heart")
                }
                #if EXTENDED_ALL
                NavigationLink(tag: NavigationItem.recipes, selection: $selection, destination: { RecipeList() }) {
                    Label("Recipes", systemImage: "book.closed")
                }
                #endif
            }
            .navigationTitle("Frucht")
            #if EXTENDED_ALL
            .safeAreaInset(edge: .bottom, spacing: 0, content: { Pocket().environmentObject(vm) })
            #endif
            
            Text("Select a category")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .ignoresSafeArea()
            
            Text("Select a smoothie")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .ignoresSafeArea()
                .toolbar {
                    SmoothieFavouriteButton()
                        .environmentObject(vm)
                        .disabled(true)
                }
        }
    }
}

struct AppSideBarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSideBarNavigation()
            .environmentObject(DataViewModel())
            .previewLayout(.sizeThatFits)
    }
}

//MARK: - Extension.

extension AppSideBarNavigation {
    enum NavigationItem {
        case menu
        case favourites
        case recipes
    }
}
