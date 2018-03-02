//
//  ViewControllerTests.swift
//  RxPokedexTests
//
//  Created by carlos.brenneisen on 2/28/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import XCTest
import UIKit
@testable import RxPokedex

final class ViewControllerTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()

        navigationController = UINavigationController()
        viewController = UIViewController()
    }
    
    //MARK: - isTopViewController Tests
    
    // The view controller has not been added to the navigation controller
    func testUnadded() {
        XCTAssertFalse(viewController.isTopViewController, "View Controller should not be added to the navigation stack")
    }
    
    // The view controller has been added to the navigation controller
    func testAdded() {
        navigationController.pushViewController(viewController, animated: false)
        XCTAssertTrue(viewController.isTopViewController, "View Controller was should be the top and only controller")
    }
    
    // The view controller, along with another one, have been added to the stack
    func testTwoControllers() {
        let secondViewController = UIViewController()
        navigationController.pushViewController(viewController, animated: false)
        navigationController.pushViewController(secondViewController, animated: false)
        
        XCTAssertTrue(secondViewController.isTopViewController, "Second View Controller should be on top")
        XCTAssertFalse(viewController.isTopViewController, "First View Controller should not be on top")
    }
    
    // Test pushing one view controller, pushing another, and then removing the last view controller
    func testPushPushPop() {
        let secondViewController = UIViewController()
        navigationController.pushViewController(viewController, animated: false)
        navigationController.pushViewController(secondViewController, animated: false)
        navigationController.popViewController(animated: false)
        
        XCTAssertFalse(secondViewController.isTopViewController, "Second View Controller should not be in the navigation stack")
        XCTAssertTrue(viewController.isTopViewController, "First View Controller should now be on top")
    }
}
