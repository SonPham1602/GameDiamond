//
//  Diamond.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 12/19/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import SpriteKit

enum DiamondType: Int, CustomStringConvertible {
    case unknown,Trang,Cam,XanhDuong,XanhLa,Do,Vang,Tim
    var spriteName: String {
        let spriteNames = [
            "diamondCam",
            "diamondTrang",
            "diamondTim",
            "diamondXanhDuong",
            "diamondXanhNgoc",
            "diamondDo"]
        return spriteNames[rawValue - 1]
    }
    
    var highlightedSpriteName: String {
        return spriteName
    }
    
    var description: String {
        return spriteName
    }
    
    static func random() -> DiamondType {
        return DiamondType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
}


func ==(lhs: Diamond, rhs: Diamond) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}

class Diamond :CustomStringConvertible, Hashable{
    var column:Int
    var row:Int
    let diamondType:DiamondType
    var sprite:SKSpriteNode?
    init(column:Int,row:Int,diamondType:DiamondType){
        self.column = column
        self.row = row
        self.diamondType = diamondType
    }
    var description: String {
        return "type:\(diamondType) square:(\(column),\(row))"
    }
    
    var hashValue: Int {
        return row*10 + column
    }
}
