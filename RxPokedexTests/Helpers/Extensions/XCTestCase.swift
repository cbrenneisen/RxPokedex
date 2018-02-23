//
//  XCTestCase.swift
//  RxPokedexTests
//
//  Created by Carlos Brenneisen on 2/22/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import XCTest

typealias Action = () -> Void

extension XCTestCase {
    
    // Used to perform a set of actions after a delay
    // Useful for testing Rx functionality
    
    // For example: when subscribing to a Driver
    // ... the subscriber gets the last event followed by every future event
    // ... so it is important to ensure that certain actions occur
    // ... after the initial subscription (or blocking) takes place
    
    // parameters
    // - delay: the amount of time in the future to execute the actions
    // - qos: the global queue on which to execute the actions
    // - action: a closure specifying the action(s) to take place
    func actWith(delay: Double = 1.0,
                 qos: DispatchQoS.QoSClass = .default,
                 action: @escaping Action) {
        
        DispatchQueue
            .global(qos: qos)
            .asyncAfter(deadline: .now() + delay) {
                action()
        }
    }
}
