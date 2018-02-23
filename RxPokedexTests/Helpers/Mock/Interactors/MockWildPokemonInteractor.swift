//
//  MockWildPokemonInteractor.swift
//  RxPokedexTests
//
//  Created by Carlos Brenneisen on 2/22/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
@testable import RxPokedex

final class MockWildPokemonInteractor: WildPokemonInteractorInterface {
    
    var pokemon: BehaviorRelay<[WildPokemon]>
    
    init(){
        //TODO
        pokemon = BehaviorRelay(value: [])
    }
    
    func capture(pokemon: WildPokemon) {
        //TODO
    }
    
    
}
