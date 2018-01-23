//
//  RemotePokemonInjection.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RemotePokemonServiceInjected { }

extension RemotePokemonServiceInjected {
    
    var remotePokemonService: RemotePokemonService { get { return InjectionMap.pokemonService } }
}

protocol RemotePokemonService {
    
    var wildPokemon: Observable<[Pokemon]> { get }
    func requestPokemon(page: Int)
}

extension RemotePokemonService {
    
    func requestPokemon(page: Int = 0){
        requestPokemon(page: page)
    }
}
