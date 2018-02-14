//
//  WildPokemom.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/9/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxDataSources

struct WildPokemon: Pokemon {
    
    let uuid: String
    let name: String
    let imagePath: String
    let date: Date
    let type: PokemonType
    
    init(number: Int, name: String, image: String, date: Date){
        self.type = .wild
        self.uuid = String(number)
        self.name = name
        self.imagePath = image
        self.date = date
    }
    
    init?(json: JSONPokemonDetail){
        
        guard let name = json.forms.first?.name,
            let image = json.sprites.values.flatMap({$0}).first else {
                return nil
        }
        self.init(number: Int.randomID, name: name, image: image, date: Date())
    }
}

extension WildPokemon: IdentifiableType, Equatable {
    
    static func ==(lhs: WildPokemon, rhs: WildPokemon) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
