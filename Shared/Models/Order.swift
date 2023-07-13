//
//  Order.swift
//  Frucht
//
//  Created by Feni Brian on 12/07/2022.
//

import Foundation

/*
 A representation of an order :-
    How many points it's worth and whether it's ready to be picked up.
 */
struct Order {
    private(set) var smoothie: Smoothie
    private(set) var points: Int
    var isReady: Bool 
}

