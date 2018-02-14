//
//  CaughtPokemonDataSource.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/12/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

final class CaughtPokemonDataSource {
    
    var capturedPokemon = PublishSubject<WildPokemon>()
    private let disposeBag = DisposeBag()
    
    func configureCell() -> TableViewSectionedDataSource<CapturedPokemonSection>.ConfigureCell {
        return { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(withIdentifier: CaughtPokemonCell.identifier, for: ip)
            guard let pokemonCell = cell as? CaughtPokemonCell else {
                fatalError("Cell/Identifier mistmatch")
            }
            pokemonCell.configureWith(pokemon: item)
            
            return pokemonCell
        }
    }
    
    
    //TODO: use this, or array of all titles?
    func configureSection() ->
        TableViewSectionedDataSource<CapturedPokemonSection>.TitleForHeaderInSection {
        return { (ds, index) in
           return ds.sectionModels[index].letter
        }
    }
}
