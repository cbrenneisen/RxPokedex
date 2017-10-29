//
//  LoadingViewController.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: LoadingViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoadingViewModel()
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.wake()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //stop observing remote changes
        super.viewDidDisappear(animated)
        viewModel.sleep()
    }
    
    func setupUI(){
        activityIndicator.hidesWhenStopped = true
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupBindings(){
        
        viewModel
            .loading
            .asDriver(onErrorJustReturn: false)
            .asObservable()
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel
            .gatheredPokemon
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] pokemon in
                self.continueWith(pokemon: pokemon)
            }).disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func continueWith(pokemon: [Pokemon]){
        performSegue(withIdentifier: "WildPokemonSegue", sender: pokemon)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let vc = segue.destination as? WildPokemonViewController,
            let pokemon = sender as? [Pokemon] else {
            fatalError("Something went incredibly wrong...")
        }
        vc.injection = pokemon
    }

}
