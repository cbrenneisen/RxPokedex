//
//  RealmPokemonService.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/9/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

final class RealmPokemonService: LocalPokemonService {
    
    private let _realm = try! Realm()  //Realm.create()
    
    var localPokemon: Observable<[CapturedPokemon]> {
        return Observable
            .array(from: _realm.objects(RealmPokemon.self))
            .map{
                $0.map {
                    CapturedPokemon(realmObj: $0)
                }
            }
    }
    
    private lazy var savedPokemon: Results<RealmPokemon> = {
        return self._realm.objects(RealmPokemon.self)
            .sorted(byKeyPath: "name", ascending: true)
    }()

    func capture(pokemon: WildPokemon, completion: persistenceErrorHandler?) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            var error: PersistenceError?
            defer { completion?(error) }
            guard let realm = Realm(error: &error) else { return }
            
            let realmPokemon = RealmPokemon()
            realmPokemon.name = pokemon.name
            realmPokemon.image = pokemon.imagePath
            //realmPokemon.date = pokemon
            
            realm.write(error: &error) {
                realm.add(realmPokemon)
            }
        }
    }
}
