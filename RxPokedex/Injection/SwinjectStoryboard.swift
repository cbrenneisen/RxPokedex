//
//  SwinjectStoryboard.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/25/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    @objc class func setup() {
        setupWildPokemonScene()
    }
    
    private class func setupWildPokemonScene(){
        //Interactor
        defaultContainer.register(WildPokemonInteractor.self) { _ in
            WildPokemonInteractor(remoteService: RemotePokemonManager())
        }
        
        // Router
        defaultContainer.register(WildPokemonRouter.self) { _ in
            WildPokemonRouter()
        }
        
        //Presenter
        //Inject  with the router and interactor from above
        defaultContainer.register(WildPokemonPresenter.self) { r in
            WildPokemonPresenter(router: r.resolve(WildPokemonRouter.self)!,
                                 interactor: r.resolve(WildPokemonInteractor.self)!)
        }
        
        //View Controller
        //Inject with the presenter from above and update the presenter's view controller
        defaultContainer.register(WildPokemonViewController.self ) { r in
            let controller = WildPokemonViewController()
            controller.presenter = r.resolve(WildPokemonPresenter.self)
            controller.presenter.router.viewController = controller
            return controller
        }
    }
}
