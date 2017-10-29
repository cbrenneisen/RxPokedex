//
//  RemotePokemonInjection.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift

protocol RemotePokemonServiceInjected { }

extension RemotePokemonServiceInjected {
    
    var remotePokemonService: RemotePokemonService { get { return InjectionMap.pokemonService } }
}

protocol RemotePokemonService {
    
    var gatheredPokemon: PublishSubject<[Pokemon]> { get }
    func getInitialPokemon()
    
    
}
