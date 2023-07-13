//
//  DataViewModel+Extensions.swift
//  Frucht
//
//  Created by Feni Brian on 14/07/2022.
//

import AuthenticationServices
import Foundation
import StoreKit

// MARK: - Smoothies and Account
extension DataViewModel {
    var searchSuggestions: [Ingredient] {
        Ingredient.all.filter { ingredient in
            ingredient.name.localizedCaseInsensitiveContains(searchString) && ingredient.name.localizedCaseInsensitiveCompare(searchString) != .orderedSame
        }
    }
    
    func orderSmoothie(_ smoothie: Smoothie) {
        order = Order(smoothie: smoothie, points: 1, isReady: false)
        addOrderToAccount()
    }
    
    func redeemSmoothie(_ smoothie: Smoothie) {
        guard var account = account, account.canRedeemFreeSmoothie else { return }
        account.pointsSpent += 10
        self.account = account
        orderSmoothie(smoothie)
    }
    
    func toggleFavorite(smoothieID: Smoothie.ID) {
        if favoriteSmoothieIDs.contains(smoothieID) {
            favoriteSmoothieIDs.remove(smoothieID)
        } else {
            favoriteSmoothieIDs.insert(smoothieID)
        }
    }
    
    func createAccount() {
        guard account == nil else { return }
        account = Account()
    }
    
    func addOrderToAccount() {
        guard let order = order else { return }
        account?.appendOrder(order)
    }
    
    func orderReadyForPickup() {
        order?.isReady = true
    }
    
    func isFavorite(smoothie: Smoothie) -> Bool {
        favoriteSmoothieIDs.contains(smoothie.id)
    }
}

// MARK: - Store API
extension DataViewModel {
    static let unlockAllRecipesIdentifier = "com.fenibrian.Frucht.unlock-all-recipes"
    
    func product(for identifier: String) -> Product? {
        return fetchedProducts.first(where: { $0.id == identifier })
    }
    
    func purchase(product: Product) {
        Task {@MainActor in
            do {
                let result = try await product.purchase()
                guard case .success(.verified(let transaction)) = result, transaction.productID == DataViewModel.unlockAllRecipesIdentifier else { return }
                self.allRecipesUnlocked = true
            } catch {
                print("Failed to purchase \(product.id): \(error)")
            }
        }
    }
}

// MARK: - Private Logic
extension DataViewModel {
    func fetchProducts() {
        Task {@MainActor in
            self.fetchedProducts = try await Product.products(for: allProductIdentifiers)
            self.unlockAllRecipesProduct = self.fetchedProducts.first { $0.id == DataViewModel.unlockAllRecipesIdentifier }
            // Check if the user owns all recipes at app launch
            await self.updateAllRecipesOwned()
        }
    }
    
    @MainActor
    private func updateAllRecipesOwned() async {
        guard let product = self.unlockAllRecipesProduct else {
            self.allRecipesUnlocked = false
            return
        }
        guard let entitlements = await product.currentEntitlement, case .verified(_) = entitlements else {
            self.allRecipesUnlocked = false
            return
        }
        self.allRecipesUnlocked = true
    }
    
    // MARK: Important
    // This method never returns; it will only suspend.
    @MainActor
    func listenForStoreUpdates() async {
        for await update in Transaction.updates {
            guard case .verified(let transaction) = update else {
                print("Unverified transaction update: \(update)")
                continue
            }
            guard transaction.productID == DataViewModel.unlockAllRecipesIdentifier else { continue }
            // If this transaction was revoked, make sure the user no longer has access to it.
            if transaction.revocationReason != nil {
                print("Revoking access to \(transaction.productID)")
                self.allRecipesUnlocked = false
            } else {
                self.allRecipesUnlocked = true
                await transaction.finish()
            }
        }
    }
}


