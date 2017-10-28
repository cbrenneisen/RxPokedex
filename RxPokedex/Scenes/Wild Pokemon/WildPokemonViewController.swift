//
//  ViewController.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/26/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Differentiator
import RxDataSources

class WildPokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    
    let disposeBag = DisposeBag()
    var presenter: WildPokemonPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WildPokemonPresenter()
        presenter
            .sections
            .bind(to: pokemonCollectionView.rx.items(dataSource: presenter.dataSource))
            .disposed(by: disposeBag)

//        let initialRandomizedSections = Randomizer(rng: PseudoRandomGenerator(4, 3), sections: initialValue())
//
//        let ticks = Observable<Int>.interval(1, scheduler: MainScheduler.instance).map { _ in () }
//        let randomSections = Observable.of(ticks)
//            .merge()
//            .scan(initialRandomizedSections) { a, _ in
//                return a.randomize()
//            }
//            .map {
//                $0.sections
//            }
//            .share(replay: 1)
//
//        let (configureCollectionViewCell, configureSupplementaryView) =  WildPokemonViewController.collectionViewDataSourceUI()
//        let cvAnimatedDataSource = RxCollectionViewSectionedAnimatedDataSource(
//            configureCell: configureCollectionViewCell,
//            configureSupplementaryView: configureSupplementaryView
//        )
//
//        randomSections
//            .bind(to: pokemonCollectionView.rx.items(dataSource: cvAnimatedDataSource))
//            .disposed(by: disposeBag)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialValue() -> [NumberSection] {
        #if true
            let nSections = 2
            let nItems = 10
            
            /*
                 let nSections = 10
                 let nItems = 2
                 */
            return (0 ..< nSections).map { (i: Int) in
                NumberSection(header: "Section \(i + 1)", numbers: `$`(Array(i * nItems ..< (i + 1) * nItems)), updated: Date())
            }
        #else
            return _initialValue
        #endif
    }
    
    static func collectionViewDataSourceUI() -> (
        CollectionViewSectionedDataSource<NumberSection>.ConfigureCell,
        CollectionViewSectionedDataSource<NumberSection>.ConfigureSupplementaryView
        ) {
            return (
                { (_, cv, ip, i) in
                    let cell = cv.dequeueReusableCell(withReuseIdentifier: WildPokemonCell.identifier, for: ip) as! WildPokemonCell
                    cell.value!.text = "\(i)"
                    return cell
                    
            },
                { (ds ,cv, kind, ip) in
                    let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WildPokemonSection.identifier, for: ip) as! WildPokemonSection
                    section.value!.text = "\(ds[ip.section].header)"
                    return section
            }
            )
    }
    

}

let _initialValue: [NumberSection] = [
    NumberSection(header: "section 1", numbers: `$`([1, 2, 3]), updated: Date())
//    NumberSection(header: "section 2", numbers: `$`([4, 5, 6]), updated: Date()),
//    NumberSection(header: "section 3", numbers: `$`([7, 8, 9]), updated: Date()),
//    NumberSection(header: "section 4", numbers: `$`([10, 11, 12]), updated: Date()),
//    NumberSection(header: "section 5", numbers: `$`([13, 14, 15]), updated: Date()),
//    NumberSection(header: "section 6", numbers: `$`([16, 17, 18]), updated: Date()),
//    NumberSection(header: "section 7", numbers: `$`([19, 20, 21]), updated: Date()),
//    NumberSection(header: "section 8", numbers: `$`([22, 23, 24]), updated: Date()),
//    NumberSection(header: "section 9", numbers: `$`([25, 26, 27]), updated: Date()),
//    NumberSection(header: "section 10", numbers: `$`([28, 29, 30]), updated: Date())
]


func `$`(_ numbers: [Int]) -> [IntItem] {
    return numbers.map { IntItem(number: $0, date: Date()) }
}


