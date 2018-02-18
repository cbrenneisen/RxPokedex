//
//  CaughtPokemonInteractor.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/13/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class CaughtPokemonInteractor: LocalPokemonServiceInjected {
        
    var pokemon: Observable<[CapturedPokemon]> { return currentPokemon.asObservable() }
    private var currentPokemon: Variable<[CapturedPokemon]>
    private var disposeBag = DisposeBag()
    
    init(){
        currentPokemon = Variable([])
        
        setupObservers()
    }
    
    private func setupObservers(){
        
        localPokemonService
            .localPokemon
            .bind(to: currentPokemon)
            .disposed(by: disposeBag)
        
        

    }
    
    
}
