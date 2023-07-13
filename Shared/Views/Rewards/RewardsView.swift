//
//  RewardsView.swift
//  Frucht
//
//  Created by Feni Brian on 20/07/2022.
//

import SwiftUI
import AuthenticationServices

struct RewardsView: View {
    @EnvironmentObject private var vm: DataViewModel
    
    var body: some View {
        ZStack {
            RewardsCard(totalStamps: vm.account?.unspentPoints ?? 0, animatedStamps: vm.account?.unstampedPoints ?? 0, hasAccount: vm.hasAccount)
                .onDisappear(perform: { vm.account?.clearUnstampedPoints() })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        #if EXTENDED_ALL
        .safeAreaInset(edge: .bottom, spacing: 0, content: { safeAreaInsetContent })
        #endif
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BubbleBackground())
    }
}

struct RewardsView_Previews: PreviewProvider {
    static let dataStore: DataViewModel = {
       var dataStore = DataViewModel()
        dataStore.createAccount()
        dataStore.orderSmoothie(.thatIsASmore)
        dataStore.orderSmoothie(.thatIsBerryBananas)
        return dataStore
    }()
    
    static var previews: some View {
        Group {
            RewardsView()
                .preferredColorScheme(.light)
            RewardsView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(dataStore)
    }
}

//MARK: - Extension.

extension RewardsView {
    var safeAreaInsetContent: some View {
        VStack(spacing: 0) {
            Divider()
            if !vm.hasAccount {
                SignInWithAppleButton(.signUp, onRequest: {_ in }, onCompletion: vm.authoriseUser(_:))
                    .frame(minWidth: 100, maxWidth: 100)
                    .padding(.horizontal, 20)
                    #if os(iOS)
                    .frame(height: 45)
                    #endif
                    .padding(.horizontal, 20)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
