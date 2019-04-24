//
//  LevelGame.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 12/19/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import Foundation
import UIKit
let NumColumns = 8
let NumRows = 8
class TargetDiamond{
    static var NumberDiamondXanhDuong:Int = 0
    static var NumberDiamondDo:Int = 0
    static var NumberDiamondXanhNgoc:Int = 0
    static var NumberDiamondTim:Int = 0
    static var NumberDiamondCam:Int = 0
    static var NumberDiamondTrang:Int = 0
    
}
class Level{
    //bien trang thai level
    // diem can dat duoc
    var targetScore = 0
    // gioi gian luoc move
    var maximunMove = 0
    // thoi gian trong game (dung cho che do limit move)
    var time = 0
    //target kim cuong
    var targetDiamond = TargetDiamond()
    //Thuoc tinh level
    //Mang cai kim cuong
    fileprivate var diamonds=ArrayDiamond<Diamond>(columns: NumColumns, rows: NumRows)
    //Co the swap
    fileprivate var possibleSwap = Set<Swap>()
    
    // khoi tao
    init(filename: String,modeGame:ModeGame) {
        guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: filename) else { return }
        if modeGame == .Classic{
             targetScore = dictionary["targetScore"] as! Int
        }
        else if modeGame == .Limit{
            targetScore = dictionary["targetScore"] as! Int
            maximunMove = dictionary["maximum"] as! Int
        }
        else if modeGame == .Time{
            targetScore = dictionary["targetScore"] as! Int
            time = dictionary["time"] as! Int
        }
        else if modeGame == .Target{
            
        }
        
       print(time)
        print(maximunMove)
        print(targetScore)
       // maximumMove = dictionary["moves"] as! Int
    }
    func shuffle()->Set<Diamond>{
        var set: Set<Diamond>
        //set = createInititalDiamonds()
        repeat{
            set = createInititalDiamonds()
            detectPossibleSwaps()
            //print("possible swaps:\(possibleSwap) \n")
        }while possibleSwap.count == 0
       return set
    }
    
    fileprivate func hasChainAt(column: Int, row: Int)->Bool{
        let diamondType = diamonds[column, row]!.diamondType
        
        // Horizontal chain check
        var horzLength = 1
        
        // Left
        var i = column - 1
        while i >= 0 && diamonds[i, row]?.diamondType == diamondType {
            i -= 1
            horzLength += 1
        }
        
        // Right
        i = column + 1
        while i < NumColumns && diamonds[i, row]?.diamondType == diamondType {
            i += 1
            horzLength += 1
        }
        if horzLength >= 3 { return true }
        
        // Vertical chain check
        var vertLength = 1
        
        // Down
        i = row - 1
        while i >= 0 && diamonds[column, i]?.diamondType == diamondType {
            i -= 1
            vertLength += 1
        }
        // Up
        i = row + 1
        while i < NumRows && diamonds[column, i]?.diamondType == diamondType {
            i += 1
            vertLength += 1
        }
        return vertLength >= 3
    }
    
    func hintDiamond()->(posA:CGPoint,posB:CGPoint){
        var check = false
        var posA = CGPoint()
        var posB = CGPoint()
        for row in 0..<NumRows{
            for column in 0..<NumColumns{
                if let diamond = diamonds[column,row]{
                    if column < NumColumns - 1{
                        if let other = diamonds[column + 1, row] {
                            diamonds[column, row] = other
                            diamonds[column + 1, row] = diamond
                            
                            if hasChainAt(column: column + 1, row: row) ||
                                hasChainAt(column: column, row: row) {
                                posA = CGPoint(x: diamond.column, y: diamond.row)
                                posB = CGPoint(x: other.column, y: other.row)
                                print (diamond)
                                print (other)
                                check=true
                            }
                            diamonds[column, row] = diamond
                            diamonds[column + 1, row] = other
                           
                        }
                        
                        
                    }
                }
                if check == true{
                    break
                }
                
            }
            if check == true{
                break
            }
            
        }
        return (posA,posB)
    }
    func detectPossibleSwaps() {
        var set = Set<Swap>()
        
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let diamond = diamonds[column, row] {
                    
                    if column < NumColumns - 1 {
                        
                        if let other = diamonds[column + 1, row] {
                            diamonds[column, row] = other
                            diamonds[column + 1, row] = diamond
                            
                            if hasChainAt(column: column + 1, row: row) ||
                                hasChainAt(column: column, row: row) {
                                set.insert(Swap(diamondA: diamond, diamondB: other))
                            }
                            diamonds[column, row] = diamond
                            diamonds[column + 1, row] = other
                        }
                    }
                    
                    if row < NumRows - 1 {
                        
                        if let other = diamonds[column, row + 1] {
                            diamonds[column, row] = other
                            diamonds[column, row + 1] = diamond
                            
                            if hasChainAt(column: column, row: row + 1) ||
                                hasChainAt(column: column, row: row) {
                                set.insert(Swap(diamondA: diamond, diamondB: other))
                            }
                            
                            diamonds[column, row] = diamond
                            diamonds[column, row + 1] = other
                        }
                    }
                }
            }
        }
        
        possibleSwap = set
    }
    
    func isPossibleSwap(_ swap: Swap) -> Bool {
        return possibleSwap.contains(swap)
    }
    
    //MARK tao mang kim cuong cho game
    
    private func createInititalDiamonds()->Set<Diamond>{
        var set = Set<Diamond>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                var diamondType : DiamondType
                repeat {
                    diamondType = DiamondType.random()
                } while(column>=2 && diamonds[column-1,row]?.diamondType == diamondType && diamonds[column-2,row]?.diamondType == diamondType) || (row>=2 && diamonds[column,row-1]?.diamondType == diamondType && diamonds[column,row-2]?.diamondType == diamondType)
                let diamond = Diamond(column: column, row: row, diamondType: diamondType)
                diamonds[column,row]=diamond
                set.insert(diamond)
            }
        }
        return set
    }
    
    //ham lay kim cuong tai vi tri tra ve kim cuong trong mang
    func diamondAt(column: Int, row: Int) -> Diamond? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return diamonds[column, row]
    }
    
    func performSwap(_ swap: Swap) {
        let columnA = swap.diamondA.column
        let rowA = swap.diamondA.row
        let columnB = swap.diamondB.column
        let rowB = swap.diamondB.row
        
        diamonds[columnA, rowA] = swap.diamondB
        swap.diamondB.column = columnA
        swap.diamondB.row = rowA
        
        diamonds[columnB, rowB] = swap.diamondA
        swap.diamondA.column = columnB
        swap.diamondA.row = rowB
    }
    
    // ham tim kiem kim cuong theo chieu ngang
    private func detectHorizontalMatches() -> Set<Chain> {
        var set = Set<Chain>()
        
        for row in 0 ..< NumRows {
            var column = 0
            while column < NumColumns-2 {
                if let diamond = diamonds[column, row] {
                    let matchType = diamond.diamondType
                    
                    if diamonds[column + 1, row]?.diamondType == matchType && diamonds[column + 2, row]?.diamondType == matchType {
                        let chain = Chain(chainType: .horizontal)
                        repeat {
                           
                            chain.add(diamond: diamonds[column, row]!)
                            if chain.length > 3{
                                print("4 ngang vua xuat hien")
                            }
                            column += 1
                        } while column < NumColumns && diamonds[column, row]?.diamondType == matchType
                        
                        set.insert(chain)
                        continue
                    }
                }
                
                column += 1
            }
        }
        
        return set
    }
    
    //Ham tim kiem kim cuong theo chieu doc
    private func detectVerticalMatches() -> Set<Chain> {
        var set = Set<Chain>()
        
        for column in 0 ..< NumColumns {
            var row = 0
            while row < NumRows-2 {
                if let diamond = diamonds[column, row] {
                    let matchType = diamond.diamondType
                    
                    if diamonds[column, row + 1]?.diamondType == matchType && diamonds[column, row + 2]?.diamondType == matchType {
                        let chain = Chain(chainType: .vertical)
                        repeat {
                           
                            chain.add(diamond: diamonds[column, row]!)
                            if chain.length > 3{
                                print("4 doc vua xuat hien")
                            }
                            row += 1
                        } while row < NumRows && diamonds[column, row]?.diamondType == matchType
                        
                        set.insert(chain)
                        continue
                    }
                }
                
                row += 1
            }
        }
        
        return set
    }
    // ham xoa kim cuong khi giong nhau
    func removeMatches() -> Set<Chain> {
        // tim kiem kim cuong
        let horizontalChains = detectHorizontalMatches()
        let verticalChains = detectVerticalMatches()
        //xoa kim cuong
        removeDiamonds(chains: horizontalChains)
        removeDiamonds(chains: verticalChains)
        // tinh diem
        calculateScores(for: horizontalChains)
        calculateScores(for: verticalChains)
        
        return horizontalChains.union(verticalChains)
    }
    
    
    // ham xoa kim cuong trong mang luu san
    private func removeDiamonds(chains: Set<Chain>) {
        for chain in chains {
            for diamond in chain.diamonds {
                diamonds[diamond.column, diamond.row] = nil
            }
        }
    }
    //Lap day kim cuong khi bi xoa
    func fillHoles() -> [[Diamond]] {
        var columns = [[Diamond]]()
        
        for column in 0 ..< NumColumns {
            var array = [Diamond]()
            for row in 0 ..< NumRows {
                if diamonds[column, row] == nil {
                    for lookup in (row + 1) ..< NumRows {
                        if let diamond = diamonds[column, lookup] {
                            diamonds[column, lookup] = nil
                            diamonds[column, row] = diamond
                            diamond.row = row
                            array.append(diamond)
                            break
                        }
                    }
                }
            }
            
            if !array.isEmpty {
                columns.append(array)
            }
        }
        
        return columns
    }
    
    
    func topUpCookies() -> [[Diamond]] {
        var columns = [[Diamond]]()
        var diamondType: DiamondType = .unknown
        
        for column in 0 ..< NumColumns {
            var array = [Diamond]()
            
            var row = NumRows - 1
            while row >= 0 && diamonds[column, row] == nil {
               
                    var newDiamondType: DiamondType
                    repeat {
                        newDiamondType = DiamondType.random()
                    } while newDiamondType == diamondType
                    diamondType = newDiamondType
                    
                    let diamond = Diamond(column: column, row: row, diamondType: diamondType)
                    diamonds[column, row] = diamond
                    array.append(diamond)
                
                
                row -= 1
            }
            
            if !array.isEmpty {
                columns.append(array)
            }
        }
        
        return columns
    }
    
    private func calculateScores(for chains: Set<Chain>) {
        // 3-chain is 60 pts, 4-chain is 120, 5-chain is 180, and so on
        for chain in chains {
            if ConstantGame.doubelScore == false{
                 chain.score = 60 * (chain.length - 2)
            }
            else {
                chain.score = 120 * (chain.length - 2)
            }
           
        }
    }
  
    
}
