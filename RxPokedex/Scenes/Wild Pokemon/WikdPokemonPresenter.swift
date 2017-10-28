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
    
    var sections: Observable<[NumberSection]> { get }
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<NumberSection> { get }
}

class WildPokemonPresenter: WildPokemonPresenterInterface {
    
    let sections: Observable<[NumberSection]>
    let dataSource: RxCollectionViewSectionedAnimatedDataSource<NumberSection>
    
    init(){
        
        let initialRandomizedSections = Randomizer(rng: PseudoRandomGenerator(4, 3),
                                                   sections: WildPokemonPresenter.initialValue())
        
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
    
    static func configureCell() -> CollectionViewSectionedDataSource<NumberSection>.ConfigureCell {
        return { (_, collectionView, indexPath, number) in
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WildPokemonCell.identifier, for: indexPath) as! WildPokemonCell
                cell.value!.text = "\(number)"
                return cell
        }
    }
    
    static func configureSection() -> CollectionViewSectionedDataSource<NumberSection>.ConfigureSupplementaryView {
        return { (ds ,cv, kind, ip) in
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WildPokemonSection.identifier, for: ip) as! WildPokemonSection
            section.value!.text = "\(ds[ip.section].header)"
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
}
