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

final class LoadingViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = LoadingViewModel()
    var disposeBag = DisposeBag()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //once we segue away, there is no use doing anything in this screen anymore
        finish()
    }
    
    //MARK: - Setup
    func setupUI(){
        activityIndicator.hidesWhenStopped = true
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupBindings(){
        
        viewModel
            .loading
            .asDriver(onErrorJustReturn: true)
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel
            .gatheredPokemon
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [unowned self] pokemon in
                self.continueWith(pokemon: pokemon)
            }).disposed(by: disposeBag)
    }
    
    private func finish(){
        disposeBag = DisposeBag()
        viewModel.sleep()
    }

    //MARK: - Navigation
    
    //Once we receive some pokemon, proceed to the next screen
    private func continueWith(pokemon: [Pokemon]){
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
