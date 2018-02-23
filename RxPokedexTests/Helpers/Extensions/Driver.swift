//
//  Driver.swift
//  RxPokedexTests
//
//  Created by Carl Brenneisen on 2/22/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import RxSwift
import RxCocoa

extension Driver {
    
    // Convenience method for testing a Driver
    
    // Drivers always return their sequences on the main queue - a must for UI updates
    // But tests also run on the main queue
    // ... So it is often necessary the Driver's events into the background
    // ... to allow the testing logic to proceed
    
    // parameters
    // - on: the scheduler on which to observe elements
    
    //return: the resulting observable
    func test(on: ConcurrentDispatchQueueScheduler) -> Observable<Element> {
        return self.asObservable().subscribeOn(on)
    }
}
