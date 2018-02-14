//
//  Pokemon.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/27/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxDataSources
import RandomKit

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


/**
 Extension to make Pokemon objects play with RxDatasources
*/
//extension Pokemon: IdentifiableType, Equatable {
//
//    typealias Identity = Int
//
//    var identity: Int {
//        return number
//    }
//
//    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
//        return lhs.number == rhs.number && lhs.date == rhs.date
//    }
//}


