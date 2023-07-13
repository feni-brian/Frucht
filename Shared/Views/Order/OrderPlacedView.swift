//
//  OrderPlacedView.swift
//  Frucht
//
//  Created by Feni Brian on 20/07/2022.
//

import SwiftUI
import StoreKit
import AuthenticationServices

struct OrderPlacedView: View {
    @EnvironmentObject private var vm: DataViewModel
    #if APPCLIP
    @State private var presentingAppStoreOverlay: Bool = false
    #endif
    var orderReady: Bool {
        guard let order = vm.order else { return false }
        return order.isReady
    }
    var presentingBottomBanner: Bool {
        #if APPCLIP
        if presentingAppStoreOverlay { return true }
        #endif
        return !vm.hasAccount
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            orderStatusCard
            Spacer()
            
            #if EXTENDED_ALL
            if presentingBottomBanner {
                bottomBanner
            }
            #endif
            
            #if APPCLIP
            Text(verbatim: "App Store Overlay")
                .hidden()
                .appStoreOverlay(isPresented: $presentingAppStoreOverlay, configuration: { SKOverlay.AppClipConfiguration(position: .bottom) })
            #endif
        }
        .onChange(of: vm.hasAccount) { _ in
            #if APPCLIP
            if vm.hasAccount { presentingAppStoreOverlay = true }
            #endif
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(content: { backgroundContent })
        .animation(.spring(response: 0.25, dampingFraction: 1), value: orderReady)
        .animation(.spring(response: 0.25, dampingFraction: 1), value: vm.hasAccount)
        .onAppear(perform: performOnAppear)
    }
}

struct OrderPlacedView_Previews: PreviewProvider {
    static let orderReady: DataViewModel = {
        let vm = DataViewModel()
        vm.orderSmoothie(Smoothie.berryBlue)
        vm.orderReadyForPickup()
        return vm
    }()
    static let orderNotReady: DataViewModel = {
        let vm = DataViewModel()
        vm.orderSmoothie(Smoothie.berryBlue)
        return vm
    }()
    
    static var previews: some View {
        Group {
            #if !APPCLIP
            OrderPlacedView()
                .environmentObject(orderNotReady)
            OrderPlacedView()
                .environmentObject(orderReady)
            #endif
        }
    }
}

//MARK: - Extension.

extension OrderPlacedView {
    var orderStatusCard: some View {
        FlipView(visibleSide: orderReady ? .back : .front) {
            OrderCard(title: "Thank you for your order!", subtitle: "We will notify you when your order is ready.")
        } back: {
            let smoothieName = vm.order?.smoothie.title ?? String(localized: "Smoothie", comment: "Fallback name for smoothie")
            OrderCard(title: "Your smoothie is ready!", subtitle: "\(smoothieName) is ready to be picked up.")
        }
        .animation(.flipCard, value: orderReady)
        .padding()
    }
    
    var bottomBanner: some View {
        VStack {
            if !vm.hasAccount {
                Text("Sign up to get rewards!")
                    .font(.headline.bold())
                SignInWithAppleButton(.signUp, onRequest: { _ in }, onCompletion: vm.authoriseUser(_:))
                    .frame(minWidth: 100, maxWidth: 400)
                    .padding(.horizontal, 20)
                    #if os(iOS)
                    .frame(height: 45)
                    #endif
            } else {
                #if APPCLIP
                if presentingAppStoreOverlay {
                    Text("Get the full smoothie experience!")
                        .font(.title2.bold())
                        .padding(.top, 15)
                        .padding(.bottom, 150)
                }
                #endif
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.bar)
    }
    
    var backgroundContent: some View {
        ZStack {
            if let order = vm.order {
                order.smoothie.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color("order_placed_background")
            }
            
            if vm.order?.isReady == false {
                Rectangle()
                    .fill(.ultraThinMaterial)
            }
        }
        .ignoresSafeArea()
    }
    
    fileprivate func performOnAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: { self.vm.orderReadyForPickup() })
        #if APPCLIP
        if vm.hasAccount { presentingAppStoreOverlay = true }
        #endif
    }
}
