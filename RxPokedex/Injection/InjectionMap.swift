//
//  InjectionMap.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation

struct InjectionMap {
    
    static var pokemonService: RemotePokemonService = RemotePokemonManager()    
}
