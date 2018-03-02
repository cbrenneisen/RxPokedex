//
//  CollectionTests.swift
//  RxPokedexTests
//
//  Created by Carl Brenneisen on 1/26/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import XCTest
import RandomKit
@testable import RxPokedex

fileprivate struct RandomUtil {
    static let thread = Xoroshiro.threadLocal
}

final class CollectionTests: XCTestCase {
    
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
    
    //MARK: - Test Fit Into
    
    //MARK: Int
    func testFitNone(){
        let nums: [Int] = []
        let result = nums.fit(into: Int.random(using: &RandomUtil.thread.pointee))
        
        XCTAssertTrue(result.isEmpty, "Array should be empty")
    }
    
    func testIntFitOne(){
        let nums = [Int.random]
        let target = Int.random
        let result = nums.fit(into: target)
        
        XCTAssertEqual(result.count, 1, "Only one element should be returned")
        XCTAssertEqual(result.reduce(0, +), target, "Array should fit into target")
    }
    
    func testIntFitTwo(){
        let nums = [15, 72]
        let target = 50
        let result = nums.fit(into: target).reduce(0, +)
        
        XCTAssertEqual(result, target, "Array should fit into target")
    }

    func testIntFitMany(){
        let nums = [13, 44, 17, 60, 77, 12]
        let target = 100
        let result = nums.fit(into: target).reduce(0, +)
        
        XCTAssertEqual(result, target, "Array should fit into target")
    }
    
    func testIntFitAlready(){
        let nums = [5, 7, 8]
        let target = 20
        let result = nums.fit(into: target)
        
        XCTAssertEqual(nums, result, "Arrays should bee equal because the sum is equal to the target")
    }


    //MARK: Double
    func testDoubleFitOne(){
        let nums = [0.5]
        let target = 10
        let result = nums.fit(into: target)
        
        XCTAssertEqual(result.count, 1, "Only one element should be returned")
        XCTAssertEqual(result.reduce(0, +), target, "Array should fit into target")
    }
    
    func testDoubleFitTwo(){
        let nums = [0.3, 0.6]
        let target = 20
        let result = nums.fit(into: target).reduce(0, +)
        
        XCTAssertEqual(result, target, "Array should fit into target")
    }
    
    func testDoubleFitMany(){
        let nums = [0.0, 0.4, 0.8, 1.0]
        let target = 20
        let result = nums.fit(into: target).reduce(0, +)
        
        XCTAssertEqual(result, target, "Array should fit into target")
    }
}
