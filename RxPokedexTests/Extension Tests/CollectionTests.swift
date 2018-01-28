//
//  CollectionTests.swift
//  RxPokedexTests
//
//  Created by Carlos Brenneisen on 1/26/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import XCTest
@testable import RxPokedex

class CollectionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIntArrayBasic() {
        let array = [150, 170, 190, 200]
        let result = array.normalize()
    
        XCTAssertEqual(result, [0.0, 0.4, 0.8, 1.0])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
