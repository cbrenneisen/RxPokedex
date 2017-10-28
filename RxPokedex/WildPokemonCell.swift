//
//  PokemonCell.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/27/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import UIKit

class WildPokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var value: UILabel!
    
    static let identifier = "WildPokemonCell"
    
    override func awakeFromNib() {

        super.awakeFromNib()
        
        pokemonImageView.contentMode = .scaleAspectFill
        pokemonImageView.clipsToBounds = true
        
        pokemonImageView.layer.borderWidth = 1.0
        pokemonImageView.layer.borderColor = UIColor.white.cgColor
        pokemonImageView.backgroundColor = UIColor.red

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //update circle when rotating the device - not the best practice here, but it works for now:
        pokemonImageView.layer.cornerRadius = self.pokemonImageView.layer.frame.size.width/2
    }

    
    
}
