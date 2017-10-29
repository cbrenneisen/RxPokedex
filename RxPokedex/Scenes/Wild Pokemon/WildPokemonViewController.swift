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

final class WildPokemonViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    
    //MARK: Flow
    var injection: [Pokemon]?
    var presenter: WildPokemonPresenter!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter = WildPokemonPresenter(initialData: injection)
        presenter
            .sections
            .bind(to: pokemonCollectionView.rx.items(
                    dataSource: presenter.dataSource))
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    private func setupUI(){
        
        navigationItem.hidesBackButton = true
        guard let nav = navigationController else { return }
        
        nav.navigationBar.isHidden = false
        nav.navigationBar.tintColor = UIColor.white
        nav.navigationBar.barTintColor = UIColor.navColor
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

}

func `$`(_ numbers: [Int]) -> [IntItem] {
    return numbers.map { IntItem(number: $0, date: Date()) }
}


