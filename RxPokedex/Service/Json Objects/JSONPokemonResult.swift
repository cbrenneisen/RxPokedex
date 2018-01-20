//
//  JsonPokemonResult.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/19/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation

/*
Represents a wrapper around an array of JSON Pokemon
i.e, requesting a batch of pokemon from the server
*/
struct JSONPokemonResult: Decodable {

    let results: [JSONPokemon]
}
