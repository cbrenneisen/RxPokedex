//
//  WikdPokemonPresenter.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import RandomKit

protocol WildPokemonPresenterInterface: class {
    
    var sections: Observable<[WildPokemonSection]> { get }
    var cvDataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection> { get }
}

final class WildPokemonPresenter: WildPokemonPresenterInterface {
    
    //MARK: Protocol
    var sections: Observable<[WildPokemonSection]> {
        return Observable
            .combineLatest(shuffler, interactor.pokemon)
            .map({ $1.shuffle() })
    }
    
    //MARK: Architecture
    private let interactor: WildPokemonInteractor
    private let dataSource: WildPokemonDataSource
    let cvDataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection>
    
    //MARK: Internals
    private let shuffler = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
    private let disposeBag = DisposeBag()
        
    init(initialData: [WildPokemon] = []){
        
        self.interactor = WildPokemonInteractor(initialData: initialData)
        self.dataSource = WildPokemonDataSource()
        self.cvDataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell: dataSource.configureCell(),
            configureSupplementaryView: dataSource.configureSection())
        setupObservers()
    }
    
    func setupObservers(){
        
        dataSource
            .capturedPokemon
            .subscribe(onNext : { [weak self] pokemon in
                self?.interactor.capture(pokemon: pokemon)
                //print("Pokemon at \(indexPath.section),\(indexPath.row) tapped ")
            }).disposed(by: disposeBag)
    }
    
    
}
