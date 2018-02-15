//
//  CapturedPokemon.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/9/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation
import RxDataSources

struct CapturedPokemon: Pokemon {
    
    let uuid: String
    let name: String
    let imagePath: String
    let type: PokemonType

    init(realmObj: RealmPokemon){
        type = .captured
        
        uuid = realmObj.pokemonID
        name = realmObj.name
        imagePath = realmObj.image
    }
}

extension CapturedPokemon: IdentifiableType, Equatable {
    
    static func ==(lhs: CapturedPokemon, rhs: CapturedPokemon) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
