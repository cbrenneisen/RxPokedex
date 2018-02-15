//
//  RemotePokemonInjection.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift

protocol RemotePokemonServiceInjected { }

extension RemotePokemonServiceInjected {
    
    var remotePokemonService: RemotePokemonService { get { return InjectionMap.pokemonService } }
}


protocol RemotePokemonService {
    
    var wildPokemon: Observable<[WildPokemon]> { get }
    func requestPokemon(page: Int)
}

extension RemotePokemonService {
    
    func requestPokemon(page: Int = 0){
        requestPokemon(page: page)
    }
}
