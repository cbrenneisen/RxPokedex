//
//  RealmPokemon.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPokemon: Object {
    
    @objc dynamic var pokemonID = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var date: Date = Date()
    
    override static func primaryKey() -> String? {
        return "pokemonID"
    }
}
