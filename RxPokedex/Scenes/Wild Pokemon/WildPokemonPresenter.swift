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
    
//    var sections: Observable<[NumberSection]> { get }
    var sections: Observable<[WildPokemonSection]> { get }
//    var dataSource: RxCollectionViewSectionedAnimatedDataSource<NumberSection> { get }
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection> { get }

}

final class WildPokemonPresenter: WildPokemonPresenterInterface {
    
//    let sections: Observable<[NumberSection]>
    let sections: Observable<[WildPokemonSection]>
//    let dataSource: RxCollectionViewSectionedAnimatedDataSource<NumberSection>
    let dataSource: RxCollectionViewSectionedAnimatedDataSource<WildPokemonSection>
    
    convenience init() {
        self.init(initialData: nil)
    }
    
    init(initialData: [Pokemon]?){
        
        if let data = initialData{
            print("Loading Presenter With: ")
            for poke in data {
                print(poke.name)
            }
        }
        
        let input = initialData ?? []
        let initialRandomizedSections = Randomizer(rng: PseudoRandomGenerator(4, 3),
                                                   sections: WildPokemonPresenter.process(inputPokemon: input))
            
            //WildPokemonPresenter.initialValue())
        
        let ticks = Observable<Int>
                    .interval(1, scheduler: MainScheduler.instance)
                    .map { _ in () }

        self.sections = Observable.of(ticks)
            .merge()
            .scan(initialRandomizedSections) { a, _ in
                return a.randomize()
            }
            .map { $0.sections }
            .share(replay: 1)
        
        self.dataSource = RxCollectionViewSectionedAnimatedDataSource(
            configureCell: WildPokemonPresenter.configureCell(),
            configureSupplementaryView: WildPokemonPresenter.configureSection())
    }
    
//    private static func configureCell() -> CollectionViewSectionedDataSource<NumberSection>.ConfigureCell {
    private static func configureCell() -> CollectionViewSectionedDataSource<WildPokemonSection>.ConfigureCell {
        return { (_, collectionView, indexPath, pokemon) in
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WildPokemonCell.identifier, for: indexPath) as! WildPokemonCell
            
                //cell.value!.text = "?" //"\(number)"            
                cell.configureWith(pokemon: pokemon as Pokemon)
                return cell
        }
    }
    
//    private static func configureSection() -> CollectionViewSectionedDataSource<NumberSection>.ConfigureSupplementaryView {
    private static func configureSection() -> CollectionViewSectionedDataSource<WildPokemonSection>.ConfigureSupplementaryView {
        return { (ds ,cv, kind, ip) in
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WildPokemonSectionView.identifier, for: ip) as! WildPokemonSectionView
            section.value!.text = "?" // "\(ds[ip.section].header)"
            return section
        }
    }
    
    private static func initialValue() -> [NumberSection] {
        let nSections = 2
        let nItems = 10
        return (0 ..< nSections).map { (i: Int) in
            NumberSection(header: "Section \(i + 1)",
                numbers: `$`(Array(i * nItems ..< (i + 1) * nItems)),
                updated: Date())
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

//let _initialValue: [NumberSection] = [
//    NumberSection(header: "section 1", numbers: `$`([1, 2, 3]), updated: Date())
//    //    NumberSection(header: "section 2", numbers: `$`([4, 5, 6]), updated: Date()),
//    //    NumberSection(header: "section 3", numbers: `$`([7, 8, 9]), updated: Date()),
//    //    NumberSection(header: "section 4", numbers: `$`([10, 11, 12]), updated: Date()),
//    //    NumberSection(header: "section 5", numbers: `$`([13, 14, 15]), updated: Date()),
//    //    NumberSection(header: "section 6", numbers: `$`([16, 17, 18]), updated: Date()),
//    //    NumberSection(header: "section 7", numbers: `$`([19, 20, 21]), updated: Date()),
//    //    NumberSection(header: "section 8", numbers: `$`([22, 23, 24]), updated: Date()),
//    //    NumberSection(header: "section 9", numbers: `$`([25, 26, 27]), updated: Date()),
//    //    NumberSection(header: "section 10", numbers: `$`([28, 29, 30]), updated: Date())
//]
//
