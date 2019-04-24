//
//  ArrayDiamond.swift
//  DoAnCuoiKi
//
//  Created by SonPham on 12/19/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import Foundation

struct ArrayDiamond<T> {
  
    let columns: Int//so cot
    let rows: Int//so dong
    fileprivate var array: Array<T?>
    
    //MARK:Khoi tao mang
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        array = Array<T?>(repeating: nil, count: rows*columns)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[row*columns + column]
        }
        set {
            array[row*columns + column] = newValue
        }
    }
}
