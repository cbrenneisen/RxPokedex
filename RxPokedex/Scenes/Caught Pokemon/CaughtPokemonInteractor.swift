//
//  CaughtPokemonInteractor.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/13/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

final class CaughtPokemonInteractor: LocalPokemonServiceInjected {
    
    var pokemon: Observable<[CapturedPokemon]> { return currentPokemon.asObservable() }
    var currentPokemon: Variable<[CapturedPokemon]>
    var disposeBag = DisposeBag()
    
    init(){
        currentPokemon = Variable([])
        
        setupObservers()
    }
    
    private func setupObservers(){
        
        localPokemonService
            .localPokemon
            .bind(to: currentPokemon)
            .disposed(by: disposeBag)
//        //TODO - figure out why 'bind' doesn't work here
//        localPokemonService
//            .localPokemon
//            .subscribe(onNext: { [weak self] localPokemon in
//                self?.currentPokemon.value = localPokemon
//            }).disposed(by: disposeBag)

    }
    
    
}
