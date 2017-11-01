//
//  WikdPokemonPresenter.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

protocol WildPokemonPresenterInterface: class {
    
    var sections: Observable<[WildPokemonSection]> { get }
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection> { get }
}

final class WildPokemonPresenter: WildPokemonPresenterInterface {
    
    let sections: Observable<[WildPokemonSection]>
    let dataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection>
    
    var wildPokemonSections: [WildPokemonSection] = []
    var interactor: WildPokemonInteractor = WildPokemonInteractor()
    
    private var randomPokemonSections: Randomizer
    private let disposeBag = DisposeBag()
    private let refreshTime: RxTimeInterval = 1 //measured in seconds
    private let reloadTime: RxTimeInterval = 10 //measured in seconds

    let test = ReplaySubject<Randomizer>.create(bufferSize: 1)
    
    convenience init() {
        self.init(initialData: nil)
    }
    
    init(initialData: [Pokemon]?){
        
        let input = initialData ?? []
        self.randomPokemonSections = Randomizer(rng: PseudoRandomGenerator(4, 3),
                                                   sections: WildPokemonPresenter.process(inputPokemon: input))
        
        //refresh every so often
        let refresh = Observable<Int>
                    .interval(refreshTime, scheduler: MainScheduler.instance)
                    .map { _ in () }
        
//        Observable
//            .combineLatest(refresh, test)
//            .map({ _, q in q.randomize()})

        self.sections =
            Observable.of(refresh)
            .merge()
            .scan(randomPokemonSections) { a, _ in return a.randomize()}
            .map { $0.sections }
            .share(replay: 1)
        
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell: WildPokemonPresenter.configureCell(),
            configureSupplementaryView: WildPokemonPresenter.configureSection())
        
        setupBindings()
        if input.isEmpty{
            self.interactor.requestPokemon()
        }
    }
    
    private func setupBindings(){

//        Observable<Int>
//            .interval(reloadTime, scheduler: MainScheduler.instance)
//            .map { _ in () }
//            .subscribe(onNext: { [weak self] _ in
//                self?.interactor.requestPokemon()
//            }).disposed(by: disposeBag)
        
        interactor
            .wildPokemon
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] gatheredPokemon in
                self?.randomPokemonSections = Randomizer(
                    rng: PseudoRandomGenerator(4, 3),
                    sections: WildPokemonPresenter.process(inputPokemon: gatheredPokemon))
            }).disposed(by: disposeBag)
    }

    private static func configureCell() -> CollectionViewSectionedDataSource<WildPokemonSection>.ConfigureCell {
        return { (_, collectionView, indexPath, pokemon) in
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WildPokemonCell.identifier,
                                                      for: indexPath) as! WildPokemonCell
            
                cell.configureWith(pokemon: pokemon as Pokemon)
                return cell
        }
    }
    
    private static func configureSection() -> CollectionViewSectionedDataSource<WildPokemonSection>.ConfigureSupplementaryView {
        return { (ds, collectionView, kind, ip) in
            let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                withReuseIdentifier: WildPokemonSectionView.identifier,
                                                                for: ip) as! WildPokemonSectionView
            section.value!.text = "?" // "\(ds[ip.section].header)"
            return section
        }
    }
    
    private static func process(inputPokemon: [Pokemon]) -> [WildPokemonSection] {
        //Apply view logic to a regular array of pokemon - divide into sections
        let nSections = 2
        let nItems = 10
        return (0 ..< nSections).map { (i: Int) in
            WildPokemonSection(
                header: "Section \(i + 1)",
                pokemon: Array(inputPokemon[i*nItems..<((i + 1) * nItems)]),
                updated: Date())
            
        }
    }
}
