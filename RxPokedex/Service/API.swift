//
//  API.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/19/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation

struct API {
    
    private struct Constants {
        static let fetchLimit = 20
    }
    
    private struct Base {
        private static let v1 = "https://pokeapi.co/api/v1/"
        private static let v2 = "https://pokeapi.co/api/v2/"
        static let current = v2
    }
    
    struct AllPokemon {
        
        private static let base = "pokemon/"
        
        static let withoutOffset = "\(Base.current)"  + base
        
        static func with(page: Int) -> String {
            return with(offset: page * Constants.fetchLimit)
        }
        
        static func with(offset: Int) -> String {
            return "\(Base.current)?limit=\(Constants.fetchLimit)&offset=\(offset)"
        }
    }
}
