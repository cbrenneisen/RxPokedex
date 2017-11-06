//
//  WikdPokemonPresenter.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

protocol WildPokemonPresenterInterface: class {
    
    var sections: Observable<[WildPokemonSection]> { get }
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection> { get }
}

final class WildPokemonPresenter: WildPokemonPresenterInterface {
    
    //MARK: Protocol
    let dataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection>
    var sections: Observable<[WildPokemonSection]> {
        return shuffler.map({ [weak self] _ in
            guard let weakSelf = self else { return [] }
            weakSelf.randomPokemonSections = weakSelf.randomPokemonSections.randomize()
            return weakSelf.randomPokemonSections.sections
        })
    }
    
    //MARK: Internals
    let interactor: WildPokemonInteractor = WildPokemonInteractor()
    private var randomPokemonSections: Randomizer
    private let shuffler = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
    private let disposeBag = DisposeBag()
    
    convenience init() {
        self.init(initialData: nil)
    }
    
    init(initialData: [Pokemon]?){
        
        let input = initialData ?? []
        self.randomPokemonSections = Randomizer(
            rng: PseudoRandomGenerator(4, 3),
            sections: WildPokemonPresenter.process(inputPokemon: input))
        
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell: WildPokemonPresenter.configureCell(),
            configureSupplementaryView: WildPokemonPresenter.configureSection())
        
        setupBindings()
        if input.isEmpty{
            self.interactor.requestPokemon()
        }
    }
    
    private func setupBindings(){

        //listen for changes to the current batch of pokemon
        interactor
            .wildPokemon
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] gatheredPokemon in
                self?.randomPokemonSections = Randomizer(
                    rng: PseudoRandomGenerator(4, 3),
                    sections: WildPokemonPresenter.process(inputPokemon: gatheredPokemon))
            }).disposed(by: disposeBag)
    }

    private static func configureCell() -> CollectionViewSectionedDataSource<WildPokemonSection>.ConfigureCell {
        return { (_, collectionView, indexPath, pokemon) in
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WildPokemonCell.identifier,
                                                      for: indexPath) as! WildPokemonCell
            
                cell.configureWith(pokemon: pokemon as Pokemon)
                return cell
        }
    }
    
    private static func configureSection() -> CollectionViewSectionedDataSource<WildPokemonSection>.ConfigureSupplementaryView {
        return { (ds, collectionView, kind, ip) in
            let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                withReuseIdentifier: WildPokemonSectionView.identifier,                                                                for: ip) as! WildPokemonSectionView
            return section
        }
    }
    
    private static func process(inputPokemon: [Pokemon]) -> [WildPokemonSection] {
        //Apply view logic to a regular array of pokemon - divide into sections
        let nSections = 2
        let nItems = 10
        return (0 ..< nSections).map { (i: Int) in
            WildPokemonSection(
                header: "Section \(i + 1)",
                pokemon: Array(inputPokemon[i*nItems..<((i + 1) * nItems)]),
                updated: Date())
            
        }
    }
}
