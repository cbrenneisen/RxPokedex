//
//  CaughtPokemonRouter.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/15/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import UIKit
import RxSwift

fileprivate struct Routes {
    
    static let loading = "LoadingSegue"
}


final class CaughtPokemonRouter {
    
    weak var viewController: UIViewController?
    
    let loading = BehaviorSubject<Bool>(value: false)
    
    
}
