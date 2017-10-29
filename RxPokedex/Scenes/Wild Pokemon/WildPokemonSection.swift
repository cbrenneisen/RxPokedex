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
    
    var header: String
    var pokemon: [Pokemon]
    var updated: Date
    
    init(header: String, pokemon: [Item], updated: Date) {
        self.header = header
        self.pokemon = pokemon
        self.updated = updated
    }
}

extension WildPokemonSection: AnimatableSectionModelType {
    typealias Item = Pokemon
    typealias Identity = String
    
    var identity: String {
        return header
    }
    
    var items: [Pokemon] {
        return pokemon
    }
    
    init(original: WildPokemonSection, items: [Item]) {
        self = original
        self.pokemon = items
    }
}

extension WildPokemonSection: Equatable {
    
    static func == (lhs: WildPokemonSection, rhs: WildPokemonSection) -> Bool {
        return lhs.header == rhs.header && lhs.items == rhs.items && lhs.updated == rhs.updated
    }
}


