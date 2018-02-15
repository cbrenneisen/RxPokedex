//
//  InjectionMap.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation

struct InjectionMap {
    
    static var pokemonService: RemotePokemonService = RemotePokemonManager()
    static var localService: LocalPokemonService = RealmPokemonService()
}
