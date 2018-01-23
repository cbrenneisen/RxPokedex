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
    var cvDataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection> { get }
}

final class WildPokemonPresenter: WildPokemonPresenterInterface {
    
    //MARK: Protocol
    var sections: Observable<[WildPokemonSection]> {
        return shuffler.map({ [weak self] _ in
            guard let weakSelf = self else { return [] }
            weakSelf.randomPokemonSections = weakSelf.randomPokemonSections.randomize()
            return weakSelf.randomPokemonSections.sections
        })
    }
    
    //MARK: Architecture
    private let interactor: WildPokemonInteractor
    private let dataSource: WildPokemonDataSource
    let cvDataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection>
    
    //MARK: Internals
    private var randomPokemonSections: Randomizer
    private let shuffler = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
    private let disposeBag = DisposeBag()
        
    init(initialData: [Pokemon] = []){
        
        self.randomPokemonSections = Randomizer(
            rng: PseudoRandomGenerator(4, 3),
            sections: WildPokemonPresenter.process(inputPokemon: initialData))

        self.interactor = WildPokemonInteractor(initialData: initialData)
        self.dataSource = WildPokemonDataSource()
        self.cvDataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell: dataSource.configureCell(),
            configureSupplementaryView: dataSource.configureSection())
        
        setupBindings()
    }
    
    private func setupBindings(){

        //listen for changes to the current batch of pokemon
        interactor
            .currentPokemon
            .observeOn(MainScheduler.instance)
            .map({ WildPokemonPresenter.process(inputPokemon: $0) })
            .map({ Randomizer(rng: PseudoRandomGenerator(4, 3), sections: $0) })
            .subscribe(onNext: { [weak self] gatheredPokemon in
                self?.randomPokemonSections = gatheredPokemon
            }).disposed(by: disposeBag)
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
