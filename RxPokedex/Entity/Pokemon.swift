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
    let name: String
    let image: String
    let date: Date
    
    init(realmObj: RealmPokemon){
        self.uuid = realmObj.name
        self.name = realmObj.name
        self.image = realmObj.name
        self.date = realmObj.date
    }
    
    init?(json: JSONPokemonDetail){
        
        guard let name = json.forms.first?.name,
            let image = json.sprites.values.flatMap({$0}).first else {
            return nil
        }
        
        let date = Date()
        self.uuid = String(date.timeIntervalSince1970)
        self.name = name
        self.image = image
        self.date = date
    }
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





