//
//  CollectionTests.swift
//  RxPokedexTests
//
//  Created by Carlos Brenneisen on 1/26/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import XCTest
import RandomKit
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
    
    //MARK: - Test INT Collections
    
    //MARK: Int Arrays
    func testIntArrayBasic() {
        let array = [150, 170, 190, 200]
        let result = array.normalize()
    
        XCTAssertEqual(result, [0.0, 0.4, 0.8, 1.0])
    }
    
    func testIntArrayEmpty() {
        let array: [Int] = []
        let result = array.normalize()
        
        XCTAssertTrue(result.isEmpty)
    }
    
    func testIntArraySingle() {
        let array1: [Int] = [1]
        let result1 = array1.normalize()
        
        let array2: [Int] = [99]
        let result2 = array2.normalize()
        
        XCTAssertEqual(result1, [1])
        XCTAssertEqual(result2, [1])
    }
    
    func testIntArrayDouble() {
        let array: [Int] = [100 , 2000]
        let result = array.normalize()
        
        XCTAssertEqual(result, [0.0, 1.0])
    }

    //MARK: Int Sets
    func testIntSetBasic() {
        let set = Set(arrayLiteral: 150, 170, 190, 200)
        let result = set.normalize().sorted(by: { $0 < $1 })
        
        XCTAssertEqual(result, [0.0, 0.4, 0.8, 1.0])
    }
    
    func testIntSetEmpty() {
        let set = Set<Int>()
        let result = set.normalize()
        
        XCTAssertTrue(result.isEmpty)
    }
    
    func testIntSetSingle() {
        let set1 = Set(arrayLiteral: 1)
        let result1 = set1.normalize()
        
        let set2 = Set(arrayLiteral: 99)
        let result2 = set2.normalize()
        
        XCTAssertEqual(result1, [1])
        XCTAssertEqual(result2, [1])
    }
    
    func testIntSetDouble() {
        let set = Set(arrayLiteral: 100, 2000)
        let result = set.normalize()
        
        XCTAssertEqual(result, [0.0, 1.0])
    }
    
    //MARK: - Fit Into Tests
    
    func testFirst(){
        let nums = [0.0, 0.4, 0.8, 1.0]
        let result = nums.fit(into: 20)
        print(result)
        XCTAssertEqual(result, [])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
