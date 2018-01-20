//
//  PokemonCell.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/27/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import UIKit
import SDWebImage

class WildPokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    static let identifier = "WildPokemonCell"
    
    override func awakeFromNib() {

        super.awakeFromNib()
        
        pokemonImageView.contentMode = .scaleAspectFill
        pokemonImageView.clipsToBounds = true
        pokemonImageView.backgroundColor = UIColor.clear
    }
    
    func configureWith(pokemon: Pokemon){
        pokemonImageView.sd_setImage(with: URL(string: pokemon.image),
                                     placeholderImage: UIImage(named: "question-mark"))
    }
    
    
    
}
