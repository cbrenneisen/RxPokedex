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

extension Array where Element == Pokemon {

    func shuffle() -> [WildPokemonSection] {
        var pokemon = shuffled(using: &Shuffler.thread.pointee)
        let maxSections = Swift.max(1, pokemon.count/4)
        let numSections = Int.random(in: 1...maxSections, using: &Shuffler.thread.pointee)
        let sections = Swift.Array(randomCount: numSections, in: 1..<20, using: &Shuffler.thread.pointee).fit(into: 20)
        
        var sec: [WildPokemonSection] = []
        for (i, n) in sections.enumerated() {
            var p: [Pokemon] = []
            for _ in 0..<n {
                p.append(pokemon.removeLast())
            }
            sec.append(WildPokemonSection(
                number: i,
                pokemon: p))
            //            var o = WildPokemonSection(
            //                header: "Section \(n + 1)",
            //                pokemon: (0..<n).map({_ in poke.removeLast() }),
            //                updated: Date())
            //            sec.append(o)
        }
        return sec
        
        //        return sections.enumerated().map({ obj in
        //            let start = max(sections[0..<obj.offset].reduce(0, +) - 1, 0)
        //            let end = start + obj.element - 1
        //            print("Adding \(start)-\(end)")
        //            return WildPokemonSection(
        //                header: "Section \(obj.element + 1)",
        //                pokemon: Array(poke[start..<end]),
        //                updated: Date())
        //        })
        //
    }

    
    
}
