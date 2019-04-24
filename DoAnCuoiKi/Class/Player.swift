//
//  Player.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 1/14/19.
//  Copyright © 2019 SonPham. All rights reserved.
//

import Foundation
// Mark:Class diem theo nhieu che do
enum ModeGame:Int {
    case None,Classic,Limit,Time,Target
    var NameMode: String {
        let Names = [
            "None",
            "Classic",
            "Limit",
            "Time",
            "Target",
           ]
        return Names[rawValue]
    }
    
}
class BestScore{
    var Mode1:Int
    var Mode2:Int
    init() {
        self.Mode1=0
        self.Mode2=0
    }
    // add new score mode 1
    func NewScoreMode1(newScore:Int){
        self.Mode1=newScore
    }
    // add new score mode 2
    func NewScoreMode2(newScore:Int){
        self.Mode2=newScore
    }
}
// Class Player
class Player{
    var Name:String
    var Score:BestScore
    init(name:String) {
        self.Name=name
        self.Score=BestScore()
    }
}
class ConstantGame{
    static var modeGame:ModeGame = ModeGame.None
    static var numberLevel = 1
    static var item1Number = 0
    static var item2Number = 0
    static var item3Number = 0
    static var item4Number = 5
    static var doubelScore = false
}
