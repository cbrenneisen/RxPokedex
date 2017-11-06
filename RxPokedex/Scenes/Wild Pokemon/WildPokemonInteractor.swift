//
//  WildPokemonInteractor.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/30/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift

protocol WildPokemonInteractorInterface {
    
    var wildPokemon: Observable<[Pokemon]> { get }
    func requestPokemon()
    func capture(pokemon: Pokemon)
}

final class WildPokemonInteractor: WildPokemonInteractorInterface,  RemotePokemonServiceInjected {

    var wildPokemon: Observable<[Pokemon]> {
        return remotePokemonService.gatheredPokemon
    }
    
    private let reloader = Observable<Int>.interval(15, scheduler: MainScheduler.instance)
    private let disposeBag = DisposeBag()
    
    init(){
        setupObservers()
    }
    
    func setupObservers(){
        Observable.of(reloader.map { _ in () })
            .merge()
            .subscribe(onNext: { [weak self] in
                self?.remotePokemonService.getInitialPokemon()
            }).disposed(by: disposeBag)
    }
    
    func requestPokemon() {
        remotePokemonService.getInitialPokemon()
    }
    
    func capture(pokemon: Pokemon) {
        //TODO
    }
}
