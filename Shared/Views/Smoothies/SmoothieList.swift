//
//  SmoothieList.swift
//  Frucht
//
//  Created by Feni Brian on 20/07/2022.
//

import SwiftUI

struct SmoothieList: View {
    @EnvironmentObject private var vm: DataViewModel
    var smoothies: [Smoothie]
    var listedSmoothies: [Smoothie] {
        smoothies
            .filter { $0.matches(vm.searchString) }
            .sorted(by: { $0.title.localizedCompare($1.title) == .orderedAscending })
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(listedSmoothies) { smoothie in
                    NavigationLink(destination: SmoothieView(smoothie: smoothie), tag: smoothie.id, selection: $vm.selectedSmoothieID, label: { SmoothieRow(smoothie: smoothie) })
                        .onChange(of: vm.selectedSmoothieID) { newValue in
                            guard let smoothieID = newValue, let smoothie = Smoothie(for: smoothieID) else { return }
                            proxy.scrollTo(smoothie.id)
                            vm.selectedSmoothieID = smoothie.id
                        }
                        .swipeActions {
                            Button(action: { withAnimation { vm.toggleFavorite(smoothieID: smoothie.id) }}, label: { Label(title: { Text("Favourite", comment: "Swipe action button in smoothie list") }, icon: { Image(systemName: "heart") }) })
                                .tint(.accentColor)
                        }
                }
            }
            .accessibilityRotor("Smoothies", entries: smoothies, entryLabel: \.title)
            .accessibilityRotor("Favourite Smoothies", entries: smoothies.filter { vm.isFavorite(smoothie: $0) }, entryLabel: \.title)
            .searchable(text: $vm.searchString) {
                ForEach(vm.searchSuggestions) { suggestion in
                    Text(suggestion.name).searchCompletion(suggestion.name)
                }
            }
        }
    }
}

struct SmoothieList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            NavigationView {
                SmoothieList(smoothies: Smoothie.all())
                    .navigationTitle(Text("Smoothies", comment: "Navigation title for the full list of smoothies."))
                    .environmentObject(DataViewModel())
            }
            .preferredColorScheme(scheme)
        }
    }
}
