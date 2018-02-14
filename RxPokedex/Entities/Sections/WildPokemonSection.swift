//
//  WildPokemonSection.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/29/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxDataSources

struct WildPokemonSection {
    
    var number: Int
    var pokemon: [WildPokemon]
    
    init(number: Int, pokemon: [Item]) {
        self.number = number
        self.pokemon = pokemon
    }
}

extension WildPokemonSection: AnimatableSectionModelType {
    typealias Item = WildPokemon
    typealias Identity = Int
    
    var identity: Int {
        return number
    }
    
    var items: [WildPokemon] {
        return pokemon
    }
    
    init(original: WildPokemonSection, items: [Item]) {
        self = original
        self.pokemon = items
    }
}

extension WildPokemonSection: Equatable {
    
    static func == (lhs: WildPokemonSection, rhs: WildPokemonSection) -> Bool {
        return lhs.number == rhs.number // && lhs.updated == rhs.updated
    }
}
