//
//  JSONPokemon.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/19/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation

/*
Represents a small pokemon object from the server
name - the name of the pokemon - i.e, Charmander
url - the corresponding detail url from which one can retrieve more info - i.e, pictures
*/

struct JSONPokemon: Decodable {
    
    let name: String
    let url: String
}
