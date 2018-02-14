//
//  Dictionary.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/14/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    mutating func alphabetize<T: Pokemon>(item: T) where Value == [T] {
        guard let letter = item.name.first else { return }
        let key = String(letter)
        if let _ = self[key]{
            self[key]?.append(item)
        }else {
            self[key] = [item]
        }
    }
}
