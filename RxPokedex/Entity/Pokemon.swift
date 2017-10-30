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
    let image: String
    let date: Date
    
//    init(realmObj: RealmPokemon){
//        self.uuid = realmObj.name
//        self.name = realmObj.name
//        self.image = realmObj.name
//        self.date = realmObj.date
//    }
    
    init(number: Int, name: String, image: String, date: Date){
        self.number = number
        self.name = name
        self.image = image
        self.date = date
    }
    
    init?(json: JSONPokemonDetail){
        
        guard let name = json.forms.first?.name,
            let image = json.sprites.values.flatMap({$0}).first else {
            return nil
        }
        
        //self.uuid = String(date.timeIntervalSince1970)
        self.name = name
        self.image = image
        self.date = Date()
        self.number = Int(arc4random_uniform(UInt32.max))
    }
}

extension Pokemon: IdentifiableType, Equatable {

    //TODO: double check if this needs to be a string
    typealias Identity = Int
    
    var identity: Int {
        return number
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.number == rhs.number && lhs.date == rhs.date
    }
}





