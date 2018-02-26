//
//  InjectionTests.swift
//  RxPokedexTests
//
//  Created by carlos.brenneisen on 2/26/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import XCTest
import SwinjectStoryboard
@testable import RxPokedex

class WildPokemonSceneTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        //setup dependencies
        SwinjectStoryboard.setup()
    }
    
    func testInteractor() {
        let interactor = SwinjectStoryboard.defaultContainer.resolve(WildPokemonInteractor.self)
        
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.remoteService)
    }
    
    func testRouter(){
        let router = SwinjectStoryboard.defaultContainer.resolve(WildPokemonRouter.self)
        
        XCTAssertNotNil(router)
    }
    
    func testPresenter(){
        let presenter = SwinjectStoryboard.defaultContainer.resolve(WildPokemonPresenter.self)
        
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.router)
        XCTAssertNotNil(presenter?.interactor)
        XCTAssertNotNil(presenter?.interactor?.remoteService)
    }
    
    func testViewController(){
        let storyboard = SwinjectStoryboard.create(
            name: "Main",
            bundle: nil,
            container: SwinjectStoryboard.defaultContainer)
        
        guard let viewController =
            storyboard.instantiateViewController(
                withIdentifier: WildPokemonViewController.identifier)
                as? WildPokemonViewController else {
            
            XCTFail("View Controller Not Found")
            return
        }
        
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.presenter)
        XCTAssertNotNil(viewController.presenter.router)
        XCTAssertNotNil(viewController.presenter.interactor)
        XCTAssertNotNil(viewController.presenter.interactor.remoteService)
    }
}
