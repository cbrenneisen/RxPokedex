//
//  Pokemon.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/27/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation
import RxDataSources

enum PokemonType {
    case wild
    case captured
}

protocol Pokemon {
    
    var uuid: String { get }
    var name: String { get }
    var imagePath: String { get }
    var type: PokemonType { get }
}

extension Pokemon {
    
    typealias Identity = String
    
    var identity: Identity {
        return uuid
    }
    
    var imageURL: URL? {
        return URL(string: imagePath)
    }
}

