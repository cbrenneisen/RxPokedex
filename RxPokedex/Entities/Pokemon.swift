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
    let number: Int
    let name: String
    let image: URL
    let date: Date

    init(number: Int, name: String, image: URL, date: Date){
        self.number = number
        self.name = name
        self.image = image
        self.date = date
    }
    
    init?(json: JSONPokemonDetail){
        
        guard let name = json.forms.first?.name,
            let image = json.sprites.values.flatMap({$0}).first,
            let imageUrl = URL(string: image) else {
            return nil
        }
        self.init(number: Int.randomID, name: name, image: imageUrl, date: Date())
    }
}

extension Pokemon: IdentifiableType, Equatable {

    typealias Identity = Int
    
    var identity: Int {
        return number
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.number == rhs.number && lhs.date == rhs.date
    }
}
