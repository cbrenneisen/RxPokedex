//
//  Collection.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 1/25/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation
import RandomKit

extension Collection where Element == Double {
    
    func fit(into: Int) -> [Int]{
        return map{ Swift.max(Int(($0 * Double(into)/2)), 1) }.fit(into: into)
    }
}

extension Collection where Element == Int  {
    
    func normalize() -> [Double] {
        return self.compactMap{ Double($0) }.normalize()
    }
    
    //decreases and increments numbers accordingly so that they all add up to one number
    func fit(into: Int) -> [Int]{
        
        //base cases
        if isEmpty { return [] }
        if count == 1 { return [into]}
        
        var items = Array(self)
        let total = items.reduce(0, +)  //the current total
    
        if total == into { return items } //if we already fit, return
        
        let size = Int(self.count)

        var offset = abs(total - into)
        var i = 0
        while offset > 0 {
            if total < into, items[i] < into-1 {
                items[i] += 1
                offset -= 1
            }else if total > into, items[i] > 1 {
                items[i] -= 1
                offset -= 1
            }
            i = (i == size-1) ? 0 : i + 1
        }
        return items
    }
}

// - applies to doubles and floats
extension Collection where Element: FloatingPoint {
    func normalize() -> [Element] {
        guard !isEmpty, let high = self.max(), let low = self.min() else { return [] }
        guard count > 1 else { return [1] }
        return compactMap({ ($0 - low) / (high - low) })
    }
}


