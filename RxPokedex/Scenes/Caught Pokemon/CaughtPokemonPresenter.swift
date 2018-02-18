//
//  CaughtPokemonViewModel.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/9/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxDataSources

final class CaughtPokemonPresenter {
    
    var disposeBag = DisposeBag()
    var interactor: CaughtPokemonInteractor
    var dataSource: CaughtPokemonDataSource
    var router: CaughtPokemonRouter
    var tvDataSource: RxTableViewSectionedAnimatedDataSource<CapturedPokemonSection>
    
    var sections: Observable<[CapturedPokemonSection]>{
        return interactor.pokemon.map({ poke in
            return poke.alphabetize()
            .map({ CapturedPokemonSection(letter: $0.key, pokemon: $0.value) })
            .sorted(by: { $0.letter < $1.letter })
        })
    }
    
    init() {
        self.router = CaughtPokemonRouter()
        self.interactor = CaughtPokemonInteractor()
        self.dataSource = CaughtPokemonDataSource()
        self.tvDataSource = RxTableViewSectionedAnimatedDataSource(configureCell: dataSource.configureCell())
        tvDataSource.titleForHeaderInSection = dataSource.configureSection()
    }
    
    func update(vc: UIViewController) {
        router.viewController = vc
    }
    
    
}
