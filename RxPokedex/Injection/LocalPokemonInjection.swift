//
//  LocalPokemonInjection.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/9/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift

typealias persistenceErrorHandler = (PersistenceError?) -> Void

protocol LocalPokemonServiceInjected { }

extension LocalPokemonServiceInjected {
    
    var localPokemonService: LocalPokemonService { get { return InjectionMap.localService } }
}

protocol LocalPokemonService {
    
    var localPokemon: Observable<[CapturedPokemon]> { get }
    func capture(pokemon: WildPokemon, completion: persistenceErrorHandler?)
}
