//
//  DataViewModel.swift
//  Frucht
//
//  Created by Feni Brian on 13/07/2022.
//

import StoreKit
import Foundation
import AuthenticationServices

/*
 This is all the data the app needs to display in its interface.
 It provides all other views that subscribe to it with the user defaults, authorisation for the user's account (if it exists), making an order for a smoothie,
 redeeming a smoothie, recommending as well as picking (or making) a favorite smoothie, and informing the user that their smoothie order is ready for pickup.
 Most important is that the view model also provides functionality for unlocking all the smoothie recipes for the in-app purchase.
 */
class DataViewModel: ObservableObject {
    @Published var order: Order?
    @Published var account: Account?
    @Published var selectedSmoothieID: Smoothie.ID?
    @Published var favoriteSmoothieIDs = Set<Smoothie.ID>()
    @Published var searchString: String = ""
    @Published var isApplePayEnable: Bool = true
    @Published var allRecipesUnlocked: Bool = false
    @Published var unlockAllRecipesProduct: Product?
    
    var hasAccount: Bool{
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    let defaults = UserDefaults(suiteName: "com.fenibrian.Frucht")
    let allProductIdentifiers = Set([DataViewModel.unlockAllRecipesIdentifier])
    var fetchedProducts: [Product] = []
    var updatesHandler: Task<Void, Error>? = nil
    
    private var userCredential: String? {
        get { defaults?.string(forKey: "UserCredential") }
        set { defaults?.setValue(newValue, forKey: "UserCredential") }
    }
    
    init() {
        /*
         Start listening for transaction information updates, such as if the user refunds the purchase,
         or if a parent approves a child's request to buy a smoothie.
         */
        updatesHandler = Task { await listenForStoreUpdates() }
        fetchProducts()
        
        guard let user = userCredential else { return }
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: user) { state, error in
            if state == .authorized || state == .transferred {
                DispatchQueue.main.async {
                    self.createAccount()
                }
            }
        }
    }
    
    deinit {
        updatesHandler?.cancel()
    }
    
    func authoriseUser(_ result: Result<ASAuthorization, Error>) {
        guard case .success(let authorisation) = result, let credential = authorisation.credential as? ASAuthorizationAppleIDCredential else {
            if case .failure(let error) = result { print("Authentication Error: \(error.localizedDescription)")}
            return
        }
        DispatchQueue.main.async {
            self.userCredential = credential.user
            self.createAccount()
        }
    }
}
