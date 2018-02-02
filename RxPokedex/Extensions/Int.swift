//
//  Int.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/24/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation

extension Int {
    static var randomID: Int {
        return Int(arc4random_uniform(UInt32.max))
    }
}
