//
//  Int.swift
//  RxPokedexTests
//
//  Created by Carlos Brenneisen on 2/5/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import XCTest
import Foundation
@testable import RxPokedex

class IntTests: XCTestCase {
    
    func testDisinct() {
        let result1 = Int.random
        let result2 = Int.random
        
        XCTAssertNotEqual(result1, result2, "Random numbers should not be the same")
    }
}
