//
//  Collection.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/25/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RandomKit

fileprivate struct Random {
    static let thread = Xoroshiro.threadLocal
}

extension Collection where Element == Double {
    
    func fit(into: Int) -> [Int]{
        let items = map{ Swift.max(Int($0 * Double(into)), 1) }
        let total = items.reduce(0, +)  //the current total
        if total == into { return items } //if we already fit, return

        let size = Int(self.count)
        let x = Swift.max(total / into - 1, 0)
        let y = total % into

        var ooo = Array(repeating: x * size, count: size)
        for _ in 0..<y {
            let index = Int.random(in: 0..<size, using: &Random.thread.pointee) ?? 0
            ooo[index] += 1
        }
        return zip(items, ooo).map({ total < into ? $0 + $1 : $0 - $1 })
    }
}

extension Collection where Element == Int  {
    
    func normalize() -> [Double] {
        return self.flatMap({ Double($0) }).normalize()
    }
    //decreases and increments numbers accordingly so that they all add up to one number
}

extension Collection where Element: FloatingPoint {
    func normalize() -> [Element] {
        guard !isEmpty, let high = self.max(), let low = self.min() else { return [] }
        guard count > 1 else { return [1] }
        return flatMap({ ($0 - low) / (high - low) })
    }
}

extension Array where Element: FloatingPoint {
    
}
