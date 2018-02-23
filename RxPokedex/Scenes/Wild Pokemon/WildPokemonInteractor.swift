//
//  WildPokemonInteractor.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/30/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RandomKit

protocol WildPokemonInteractorInterface {
    
    var pokemon: BehaviorRelay<[WildPokemon]> { get }
    func capture(pokemon: WildPokemon)
}

final class WildPokemonInteractor: WildPokemonInteractorInterface, RemotePokemonServiceInjected, LocalPokemonServiceInjected {

    var error = PublishSubject<String>()
    var pokemon = BehaviorRelay<[WildPokemon]>(value: [])

    private var page = 0
    private let reloader = Observable<Int>.interval(15, scheduler: MainScheduler.instance)
    private let disposeBag = DisposeBag()
    
    init(){
        setupObservers()
    }
    
    private func setupObservers(){
        
        remotePokemonService
            .wildPokemon
            .ignoreWhen{ $0.isEmpty }
            .bind(to: pokemon)
            .disposed(by: disposeBag)
        
        reloader
            .subscribe(onNext: { [weak self] _ in
                self?.refreshPokemon()
            }).disposed(by: disposeBag)
    }
        
    private func refreshPokemon() {
        print("requesting: \(page)")
        remotePokemonService.requestPokemon(page: page)
        page +=  1
    }
    
    func capture(pokemon: WildPokemon) {
        print("Captured \(pokemon.name)!")
        self.pokemon.accept(self.pokemon.value.filter({ $0.uuid != pokemon.uuid }))

        localPokemonService.capture(pokemon: pokemon){ error in
            //TODO: handle error
            if let e = error {
                print(e.description)
            }
        }
    }
}
