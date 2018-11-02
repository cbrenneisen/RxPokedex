//
//  Dictionary.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/14/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    // Used to alphabetize multiple arrays of Pokemon
    // Given that the dictionary's value type is a Pokemon Array
    // ... sort each array object according to the Pokemon's name
    //
    // return: Dictionary<String, [Pokemon]>
    // the keys will still correspond to the same pokemon object but they will now be sorted
    
    func alphabetize<T: Pokemon>() -> [String: [T]] where Value == [T] {
        return mapValues({ $0.sorted(by: {$0.name > $1.name }) })
    }
    
    // Used to place a Pokemon object into the appropriate alphabetical array
    // Given that the dictionary's value type is a Pokemon Array
    // ... and given the Pokemon object to place ...
    // ... Determine whether the appropriate array for that Pokemon exists
    //     ... If it exists: add it to the end of the appropriate array
    //     ... Else: initialze the array with the Pokemon under the appropriate key
    //
    // The arrays will not be sorted here; They will merely have the correct (unsorted) Pokemon
    
    mutating func placeAlphabetically<T: Pokemon>(_ item: T) where Value == [T] {
        guard let letter = item.name.first else { return }
        let key = String(letter).uppercased()
        if let _ = self[key]{
            self[key]!.append(item)
        }else {
            self[key] = [item]
        }
    }
}

