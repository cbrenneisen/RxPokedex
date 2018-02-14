//
//  Array.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/7/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RandomKit

fileprivate struct Shuffler {
    static var thread = Xoroshiro.threadLocal
}

extension Array where Element == WildPokemon {

    func shuffle() -> [WildPokemonSection] {
        var pokemon = shuffled(using: &Shuffler.thread.pointee)
        let sections = sectionCounts()
        
        return sections.enumerated().map({ obj in
            let start = sections.count > 1 ? sections[0..<obj.offset].reduce(0, +) : 0
            let end = start + obj.element
            return WildPokemonSection(
                number: obj.offset,
                pokemon: Array(pokemon[start..<end]))
        })
    }
}

extension Array where Element: Pokemon {
    
    func alphabetize() -> [String: [Element]] {
        return reduce(into: [String: [Element]]()) { _ = $0; $0.alphabetize(item: $1) }
    }
}

extension Array {
    func sectionCounts(maxSections: Int? = nil) -> [Int]{
        if isEmpty { return [] }
        let maxSec = maxSections ?? Swift.max(1, count/4)
        let numSec = Int.random(in: 1...maxSec, using: &Shuffler.thread.pointee)
        return Swift.Array(randomCount: numSec, in: 1..<count, using: &Shuffler.thread.pointee).fit(into: count)
    }
}
