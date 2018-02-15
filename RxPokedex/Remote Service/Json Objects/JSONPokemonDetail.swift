//
//  JSONMapping.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation

/**
Represents a detailed pokemon object from the server
 
 - property forms: an array containing variances (normal, shiny, rare, etc)
 - property sprites: an array containing image urls for the corresponding variances
 */

struct JSONPokemonDetail: Decodable {

    let forms: [JSONPokemon]
    let sprites: [String: String?]
}
