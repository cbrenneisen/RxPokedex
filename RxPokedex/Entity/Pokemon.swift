//
//  Pokemon.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/27/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxDataSources

struct Pokemon {
    let uuid: String
    let image: String
    let date: Date
}

extension Pokemon: IdentifiableType, Equatable {

    //TODO: double check if this needs to be a string
    typealias Identity = String
    
    var identity: String {
        return uuid
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.date == rhs.date
    }
}





