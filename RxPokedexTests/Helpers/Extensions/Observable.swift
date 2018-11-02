//
//  Observable.swift
//  RxPokedexTests
//
//  Created by Carl Brenneisen on 2/22/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import RxSwift
import RxBlocking
import XCTest

extension Observable {
    
    // A simple wrapper used to block and receive elements from an Observable
    
    // First, the Observable is converted to a a Blocking Observable
    // ... After that, an array of emitted elements is extracted, which may throw an exception
    // ... If an exception is thrown, it is caught and the current test will fail
    // ... Otherwise, simply return the extracted elements
    
    // return: an array of all emitted elements, in order
    func toBlockingArray(timeout: RxTimeInterval? = nil) -> [Element] {
        do {
            return try self.toBlocking(timeout: timeout).toArray()
        } catch {
            XCTFail(error.localizedDescription)
        }
        return []
    }
}
