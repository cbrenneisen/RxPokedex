//
//  Parse.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 1/19/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift

struct Parse {
    static var error = PublishSubject<String>()

    struct Pokemon {
        struct Summary {
            static func list(from: Data) -> [JSONPokemon]? {
                do { return try JSONDecoder().decode(JSONPokemonResult.self, from: from).results }
                catch let e as NSError {
                    error.onNext(e.localizedDescription)
                    return nil
                }
            }
        }
        struct Detail {
            static func single(from: Data) -> JSONPokemonDetail? {
                do { return try JSONDecoder().decode(JSONPokemonDetail.self, from: from) }
                catch let e as NSError {
                    error.onNext(e.localizedDescription)
                    return nil
                }
            }
        }
    }
}
