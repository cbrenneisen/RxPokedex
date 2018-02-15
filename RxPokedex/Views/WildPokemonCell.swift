//
//  PokemonCell.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/27/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxGesture

final class WildPokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    static let identifier = "WildPokemonCell"
    
    var captured: Observable<Void> {
        return pokemonImageView.rx
            .tapGesture()
            .when(.ended)
            .throttle(0.3, scheduler: MainScheduler.instance)
            .map { _ in Void() }
    }
    
    private(set) var disposeBag = DisposeBag() //used for outside subscriptions
    private let _disposeBag = DisposeBag() //used for internal subscriptions
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        setupObservers()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    //MARK: - Setup
    private func setupUI(){
        pokemonImageView.contentMode = .scaleAspectFill
        pokemonImageView.clipsToBounds = true
        pokemonImageView.backgroundColor = UIColor.clear
    }
    
    private func setupObservers(){
        captured
            .subscribe(onNext: { [weak self] in
                self?.capture()
            }).disposed(by: _disposeBag)
    }
    
    //MARK: - Image Setting
    func configureWith(pokemon: WildPokemon){
        pokemonImageView.kf.setImage(
            with: pokemon.imageURL,
            placeholder: UIImage.Image.placeholder)
    }
    
    private func capture(){
        pokemonImageView.kf.setImage(
            with: UIImage.Path.capturedPokemon,
            placeholder: nil)
    }
}
