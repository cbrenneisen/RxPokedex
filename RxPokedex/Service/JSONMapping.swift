//
//  JSONMapping.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation


struct JSONPokemonResult: Decodable {
    let results: [JSONPokemon]
}
struct JSONPokemon: Decodable {
    let name: String
    let url: String
}
struct JSONPokemonDetail: Decodable {
    let forms: [JSONPokemon]
    let sprites: [String: String?]
}
