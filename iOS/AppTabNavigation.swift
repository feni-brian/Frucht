//
//  AppTabNavigation.swift
//  Frucht
//
//  Created by Feni Brian on 22/07/2022.
//

import SwiftUI

struct AppTabNavigation: View {
    @State private var selection: Tab = .menu
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView { SmoothieMenu() }
                .tabItem {
                    let menuText = Text("Menu", comment: "Smoothie menu tab title")
                    Label(title: { menuText }, icon: { Image(systemName: "list.bullet") })
                        .accessibilityLabel(menuText)
                }
                .tag(Tab.menu)
            NavigationView { FavouriteSmoothies() }
                .tabItem {
                    let favouriteText = Text("Favourites", comment: "Favourite smoothies tab title")
                    Label(title: { favouriteText }, icon: { Image(systemName: "heart.fill") })
                        .accessibilityLabel(favouriteText)
                }
                .tag(Tab.favourites)
            #if EXTENDED_ALL
            NavigationView { RewardsView() }
                .tabItem {
                    let rewardsText = Text("Rewards", comment: "Smoothie rewards tab title")
                    Label(title: { rewardsText }, icon: { Image(systemName: "seal.fill") })
                        .accessibilityLabel(rewardsText)
                }
                .tag(Tab.menu)
            NavigationView { RecipeList() }
                .tabItem {
                    let recipeText = Text("Recipes", comment: "Smoothie recipes tab title")
                    Label(title: { recipeText }, icon: { Image(systemName: "book.closed.fill") })
                        .accessibilityLabel(recipeText)
                }
                .tag(Tab.menu)
            #endif
        }
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
            .environmentObject(DataViewModel())
    }
}

//MARK: - Extension.

extension AppTabNavigation {
    enum Tab {
        case menu
        case favourites
        case rewards
        case recipes
    }
}
