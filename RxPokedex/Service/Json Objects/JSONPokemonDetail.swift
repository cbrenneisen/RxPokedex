//
//  JSONMapping.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation

/*
Represents a detailed pokemon object from the server
forms: an array containing the different pokemon instances (normal, shiny, etc)
sprites: an array containing image urls for all the different instances
 */

struct JSONPokemonDetail: Decodable {

    let forms: [JSONPokemon]
    let sprites: [String: String?]
}
