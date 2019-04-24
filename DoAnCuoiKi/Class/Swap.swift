//
//  Swap.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 12/20/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import Foundation
struct Swap: CustomStringConvertible, Hashable {
    let diamondA: Diamond
    let diamondB: Diamond
    
    init(diamondA: Diamond, diamondB: Diamond) {
        self.diamondA = diamondB
        self.diamondB = diamondA
    }
    
    var description: String {
        return "swap \(diamondA) with \(diamondB)"
    }
    
    var hashValue: Int {
        return diamondA.hashValue ^ diamondB.hashValue
    }
    
    static func ==(lhs: Swap, rhs: Swap) -> Bool {
       return (lhs.diamondA == rhs.diamondA && lhs.diamondB == rhs.diamondB) || (lhs.diamondB == rhs.diamondA && lhs.diamondA == rhs.diamondB)
   }
}
