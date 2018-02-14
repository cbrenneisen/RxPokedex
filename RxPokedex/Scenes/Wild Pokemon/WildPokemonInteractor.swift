//
//  WildPokemonInteractor.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/30/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RandomKit

protocol WildPokemonInteractorInterface {
    
    var pokemon: Observable<[WildPokemon]> { get }
    func capture(pokemon: WildPokemon)
}

final class WildPokemonInteractor: WildPokemonInteractorInterface, RemotePokemonServiceInjected, LocalPokemonServiceInjected {

    var pokemon: Observable<[WildPokemon]> { return currentPokemon.asObservable() }
    var currentPokemon: Variable<[WildPokemon]>

    private var page: Int
    private let reloader = Observable<Int>.interval(15, scheduler: MainScheduler.instance)
    private let disposeBag = DisposeBag()
    
    init(initialData: [WildPokemon]){
        self.page = initialData.isEmpty ? 0 : 1
        self.currentPokemon = Variable<[WildPokemon]>(initialData)
        
        setupObservers()
    }
    
    private func setupObservers(){
        
        remotePokemonService
            .wildPokemon
            .bind(to: currentPokemon)
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
        currentPokemon.value = currentPokemon.value.filter({ $0.uuid != pokemon.uuid })
        localPokemonService.capture(pokemon: pokemon){ error in
            //TODO: handle error
            if let e = error {
                print(e.description)
            }
        }
    }
}
