//
//  LoadingViewModel.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoadingViewModel: RemotePokemonServiceInjected {
    
    let gatheredPokemon = PublishSubject<[Pokemon]>()
    let loading = BehaviorSubject<Bool>(value: true)
    var disposeBag = DisposeBag()
        
    init(){
        setupBindings()
        remotePokemonService.getInitialPokemon()
    }
    
    func setupBindings(){
        remotePokemonService
            .gatheredPokemon
            .subscribe(onNext: { [unowned self] pokemon in
                self.loading.onNext(false)
                self.gatheredPokemon.onNext(pokemon)
            })
            .disposed(by: disposeBag)
    }
    
    func sleep(){
        disposeBag = DisposeBag()
    }
    
    func wake(){
        disposeBag = DisposeBag()
        setupBindings()
    }
    
}
