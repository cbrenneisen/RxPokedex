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
    
    var currentPokemon: BehaviorSubject<[Pokemon]> { get }
    func capture(pokemon: Pokemon)
}

final class WildPokemonInteractor: WildPokemonInteractorInterface, RemotePokemonServiceInjected {

    var currentPokemon: BehaviorSubject<[Pokemon]>

    private var page: Int
    private let reloader = Observable<Int>.interval(15, scheduler: MainScheduler.instance)
    private let disposeBag = DisposeBag()
    
    init(initialData: [Pokemon]){
        self.page = initialData.isEmpty ? 0 : 1
        self.currentPokemon = BehaviorSubject<[Pokemon]>(value: initialData)
        
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
    
    func capture(pokemon: Pokemon) {
        //TODO
    }
}
