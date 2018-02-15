//
//  Int.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 1/24/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation
import RandomKit

fileprivate struct RandomUtil {
    static let thread = Xoroshiro.threadLocal
}

extension Int {
    static var randomID: Int {
        return Int(arc4random_uniform(UInt32.max))
    }
    
    static var random: Int {
        return Int.random(using: &RandomUtil.thread.pointee)
    }
    
    static func random(max: Int) -> Int {
        return Int.random(in: 1...max, using: &RandomUtil.thread.pointee)
    }
}
