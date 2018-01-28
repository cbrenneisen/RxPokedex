//
//  Collection.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/25/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import Darwin

extension Collection where Element == Int  {
    func normalize() -> [Double] {
        return self.flatMap({ Double($0) }).normalize()
    }
}

extension Collection where Element: FloatingPoint {
    func normalize() -> [Element] {
        guard let high = self.max(), let low = self.min() else { return [] }
        return flatMap({ ($0 - low) / (high - low) })
    }
}
