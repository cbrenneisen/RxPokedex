//
//  CaughtPokemonSection.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/12/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation
import RxDataSources

struct CapturedPokemonSection {
    
    var letter: String
    var pokemon: [CapturedPokemon]
    
    init(letter: String, pokemon: [Item]) {
        self.letter = letter
        self.pokemon = pokemon
    }
}

extension CapturedPokemonSection: AnimatableSectionModelType {
    typealias Item = CapturedPokemon
    typealias Identity = String
    
    var identity: String {
        return letter
    }
    
    var items: [CapturedPokemon] {
        return pokemon
    }
    
    init(original: CapturedPokemonSection, items: [Item]) {
        self = original
        self.pokemon = items
    }
}

extension CapturedPokemonSection: Equatable {
    
    static func == (lhs: CapturedPokemonSection, rhs: CapturedPokemonSection) -> Bool {
        return lhs.letter == rhs.letter
    }
}
