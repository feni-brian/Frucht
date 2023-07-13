//
//  RecipeList.swift
//  Frucht
//
//  Created by Feni Brian on 21/07/2022.
//

import SwiftUI

struct RecipeList: View {
    @EnvironmentObject private var vm: DataViewModel
    var smoothies: [Smoothie] {
        Smoothie.all(includingPaid: vm.allRecipesUnlocked)
            .filter { $0.matches(vm.searchString) }
            .sorted { $0.title.localizedCompare($1.title) == .orderedAscending }
    }
    
    var body: some View {
        List {
            #if os(iOS)
            if !vm.allRecipesUnlocked {
                firstListBlock
            }
            #endif
            secondListBlock
        }
        #if os(iOS)
        .listStyle(.insetGrouped)
        #elseif os(macOS)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if !vm.allRecipesUnlocked {
                unlockButton
                    .padding(8)
            }
        }
        #endif
        .navigationTitle(Text("Recipes", comment: "Title of the 'recipes' app section showing the list of smoothie recipes."))
        .animation(.spring(response: 1, dampingFraction: 1), value: vm.allRecipesUnlocked)
        .accessibilityRotor("Favourite Smoothies", entries: smoothies.filter { vm.isFavorite(smoothie: $0) }, entryLabel: \.title)
        .accessibilityRotor("Smoothies", entries: smoothies, entryLabel: \.title)
        .searchable(text: $vm.searchString) {
            ForEach(vm.searchSuggestions) { suggestion in
                Text(suggestion.name)
                    .searchCompletion(suggestion.name)
            }
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static let unlocked: DataViewModel = {
        let store = DataViewModel()
        store.allRecipesUnlocked = true
        return store
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                RecipeList()
            }
            .environmentObject(DataViewModel())
            .previewDisplayName("Locked")
            
            NavigationView {
                RecipeList()
            }
            .environmentObject(unlocked)
            .previewDisplayName("Unlocked")
        }
        .previewLayout(.sizeThatFits)
    }
}

//MARK: - Extension.

extension RecipeList {
    @ViewBuilder
    var unlockButton: some View {
        Group {
            if let product = vm.unlockAllRecipesProduct {
                RecipeUnlockButton(product: RecipeUnlockButton.Product(for: product), purchaseAction: { vm.purchase(product: product) })
            } else {
                RecipeUnlockButton(product: RecipeUnlockButton.Product(title: "Unlock All Recipes", description: "Loading...", availability: .unavailable), purchaseAction: {})
            }
        }
        .transition(.scale.combined(with: .opacity))
    }
    
    var firstListBlock: some View {
        Section {
            unlockButton
                .listRowInsets(EdgeInsets())
                .listRowBackground(EmptyView())
                #if os(iOS)
                .listSectionSeparator(.hidden)
                .listRowSeparator(.hidden)
                #endif
        }
        #if os(iOS)
        .listRowSeparator(.hidden)
        #endif
    }
    
    var secondListBlock: some View {
        ForEach(smoothies) { smoothie in
            NavigationLink(
                tag: smoothie.id,
                selection: $vm.selectedSmoothieID,
                destination: { RecipeView(smoothie: smoothie).environmentObject(vm) },
                label: { SmoothieRow(smoothie: smoothie).padding(.vertical, 5) })
        }
    }
}
