//
//  WildPokemonInteractor.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/30/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift

protocol WildPokemonInteractorInterface {
    
    var wildPokemon: Observable<[Pokemon]> { get }
    func requestPokemon()
    func capture(pokemon: Pokemon)
}

final class WildPokemonInteractor: WildPokemonInteractorInterface,  RemotePokemonServiceInjected {

    var wildPokemon: Observable<[Pokemon]> {
        return remotePokemonService.gatheredPokemon
    }
    
    init(){
        
    }
    
    func requestPokemon() {
        remotePokemonService.getInitialPokemon()
    }
    
    func capture(pokemon: Pokemon) {
        //TODO
    }
    
}
