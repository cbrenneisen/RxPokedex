//
//  Dictionary.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/14/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    func alphabetize<T: Pokemon>() -> [String: [T]] where Value == [T] {
        return mapValues({ $0.sorted(by: {$0.name > $1.name }) })
    }
    
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

