//
//  CaughtPokemonViewController.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/9/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

final class CaughtPokemonViewController: UIViewController {

    @IBOutlet weak var pokemonTableView: UITableView!
    
    let presenter = CaughtPokemonPresenter()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupBindings(){
        presenter
            .sections
            .bind(to: pokemonTableView.rx.items(
                dataSource: presenter.tvDataSource))
            .disposed(by: disposeBag)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
