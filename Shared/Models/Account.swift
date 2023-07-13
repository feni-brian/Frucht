//
//  Account.swift
//  Frucht
//
//  Created by Feni Brian on 13/07/2022.
//

import Foundation

/*
 This is a representation of a customer's account.
 It is used for calculating free smoothie redemption(s).
 */

struct Account {
    var orderHistory = [Order]()
    var pointsSpent: Int = 0
    var unstampedPoints: Int = 0
    var pointsEarned: Int { orderHistory.reduce(0, { $0 + $1.points }) }
    var unspentPoints: Int { pointsEarned - pointsSpent }
    var canRedeemFreeSmoothie: Bool { unspentPoints >= 10 }
    
    mutating func clearUnstampedPoints() {
        unstampedPoints = 0
    }
    
    mutating func appendOrder(_ order: Order) {
        orderHistory.append(order)
        unstampedPoints += order.points
    }
}
