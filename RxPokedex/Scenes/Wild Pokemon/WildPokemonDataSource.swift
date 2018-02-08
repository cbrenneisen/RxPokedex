//
//  WildPokemonDataSource.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/19/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

final class WildPokemonDataSource {
    
    var capturedPokemon = PublishSubject<Pokemon>()
    private let disposeBag = DisposeBag()
    
    func configureCell() -> CollectionViewSectionedDataSource<WildPokemonSection>.ConfigureCell {
        return { [unowned self] (_, collectionView, indexPath, pokemon) in
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WildPokemonCell.identifier,
                for: indexPath) as! WildPokemonCell
            
            cell.configureWith(pokemon: pokemon as Pokemon)
            cell.captured
                .map({ _ in pokemon })
                .bind(to: self.capturedPokemon)
                .disposed(by: cell.disposeBag)
            
            return cell
        }
    }
    
    func configureSection() -> CollectionViewSectionedDataSource<WildPokemonSection>.ConfigureSupplementaryView {
        return { (ds, collectionView, kind, indexPath) in
            
            let section = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: WildPokemonSectionView.identifier,
                for: indexPath) as! WildPokemonSectionView
            
            return section
        }
    }
}
