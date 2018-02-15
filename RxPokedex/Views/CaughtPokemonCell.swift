//
//  CaughtPokemonCell.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/9/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import UIKit

final class CaughtPokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier = "CaughtPokemonCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        pokemonImageView.layer.cornerRadius = pokemonImageView.frame.size.width/2
        pokemonImageView.layer.borderWidth = 1.0
        pokemonImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(pokemon: CapturedPokemon){
        pokemonImageView.kf.setImage(
            with: pokemon.imageURL,
            placeholder: UIImage.Image.placeholder)
        
        nameLabel.text = pokemon.name.capitalized
    }
}
