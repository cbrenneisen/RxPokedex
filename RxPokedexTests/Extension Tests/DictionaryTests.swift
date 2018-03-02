//
//  DictionaryTests.swift
//  RxPokedexTests
//
//  Created by carlos.brenneisen on 2/28/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import XCTest
@testable import RxPokedex

final class DictionaryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmpty() {
        let dictionary: [String: [CapturedPokemon]] = [:]
        let result = dictionary.alphabetize()
        
        XCTAssertTrue(result.isEmpty)
    }
    
    func testNonEmpty(){
        //TODO
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
