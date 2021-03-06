//
//  JSONPokemon.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 1/19/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation

/**
Represents a basic pokemon object from the server
 
 - property name - the name of the pokemon - i.e, Charmander
 - property url - the corresponding detail url from which one can retrieve more info (i.e pictures)
*/

struct JSONPokemon: Decodable {
    
    let name: String
    let url: String
}
