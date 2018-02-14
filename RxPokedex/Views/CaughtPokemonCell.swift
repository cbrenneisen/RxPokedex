//
//  CaughtPokemonCell.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 2/9/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import UIKit

final class CaughtPokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier = "CaughtPokemonCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWith(pokemon: CapturedPokemon){
        pokemonImageView.kf.setImage(
            with: pokemon.imageURL,
            placeholder: UIImage.Image.placeholder)
        
        nameLabel.text = pokemon.name
    }
}
