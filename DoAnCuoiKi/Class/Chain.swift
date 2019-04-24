//
//  Chain.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 12/31/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import Foundation
class Chain: Hashable, CustomStringConvertible {
    var diamonds = [Diamond]()
    
    var score = 0
    
    enum ChainType: CustomStringConvertible {
        case horizontal
        case vertical
        
        var description: String {
            switch self {
            case .horizontal:
                return "Horizontal"
            case .vertical:
                return "Vertical"
            }
        }
    }
    
    var chainType: ChainType
    
    init(chainType: ChainType) {
        self.chainType = chainType
    }
    
    func add(diamond: Diamond) {
        diamonds.append(diamond)
    }
    
    func firstDiamond() -> Diamond{
        return diamonds[0]
    }
    
    func lastDiamond() -> Diamond {
        return diamonds[diamonds.count - 1]
    }
    
    var length: Int {
        return diamonds.count
    }
    
    var description: String {
        return "type:\(chainType) cookies:\(diamonds)"
    }
    
    var hashValue: Int {
        return diamonds.reduce(0) { $0.hashValue ^ $1.hashValue }
    }
    
    static func ==(lhs: Chain, rhs: Chain) -> Bool {
        return lhs.diamonds == rhs.diamonds
        
    }
}
