//
//  JsonPokemonResult.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/19/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation

/**
 Represents a wrapper around an array of JSON Pokemon

 - property results: an array of pokemon objects
 */
struct JSONPokemonResult: Decodable {
    let results: [JSONPokemon]
}
