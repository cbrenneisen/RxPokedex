//
//  LoadingViewModel.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoadingViewModel: RemotePokemonServiceInjected {
    
    let gatheredPokemon = PublishSubject<[Pokemon]>()
    
    var title: Observable<String>{
        return loading.map({ $0 ? "Looking for Pokemon" : "Found Pokemon!" })
    }
    
    let loading = BehaviorSubject<Bool>(value: true)
    var disposeBag = DisposeBag()
        
    init(){
        setupBindings()
        remotePokemonService.requestPokemon()
    }
    
    func setupBindings(){
        remotePokemonService
            .wildPokemon
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
