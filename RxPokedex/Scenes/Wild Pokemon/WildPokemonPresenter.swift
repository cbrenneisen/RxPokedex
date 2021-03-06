//
//  WikdPokemonPresenter.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol WildPokemonPresenterInterface: class {
    
    var sections: Observable<[WildPokemonSection]> { get }
    var state: Driver<WildPokemonState> { get }
    var cvDataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection> { get }
}

final class WildPokemonPresenter: WildPokemonPresenterInterface {
    
    //MARK: Protocol
    var sections: Observable<[WildPokemonSection]> {
        return Observable
            .combineLatest(shuffler, interactor.pokemon)
            .map({ $1.shuffle() })
    }
    
    var state: Driver<WildPokemonState> {
        return Observable
            .combineLatest(loading, error)
            .map({ WildPokemonState(loading: $0, error: $1) })
            .asDriver(onErrorJustReturn: .error)
    }
    
    //MARK: Internals
    private var error = BehaviorSubject<Bool>(value: false)
    private var loading = BehaviorSubject<Bool>(value: true)
    
    //MARK: Architecture
    let interactor: WildPokemonInteractor
    let dataSource: WildPokemonDataSource
    let router: WildPokemonRouter
    let cvDataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection>
    
    //MARK: Internals
    private let shuffler = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
    private let disposeBag = DisposeBag()
        
    init(router: WildPokemonRouter, interactor: WildPokemonInteractor){
        self.router = router
        self.interactor = interactor
        self.dataSource = WildPokemonDataSource()
        self.cvDataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell: dataSource.configureCell(),
            configureSupplementaryView: dataSource.configureSection())
        setupObservers()
    }
    
    func setupObservers(){
        
        interactor
            .pokemon
            .map{ $0.isEmpty }
            .bind(to: loading)
            .disposed(by: disposeBag)
        
        interactor
            .error
            .map{ !$0.isEmpty }
            .bind(to: error)
            .disposed(by: disposeBag)
        
        dataSource
            .capturedPokemon
            .subscribe(onNext : { [weak self] pokemon in
                self?.interactor.capture(pokemon: pokemon)
            }).disposed(by: disposeBag)
        
        state
            .drive(onNext: { [weak self] state in
                self?.router.state = state
            }).disposed(by: disposeBag)
    }
    
    func update(viewController: WildPokemonViewController){
        router.viewController = viewController
    }
}
