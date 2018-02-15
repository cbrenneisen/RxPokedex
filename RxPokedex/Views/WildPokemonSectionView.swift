//
//  WildPokemonSection.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/27/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import UIKit

class WildPokemonSectionView: UICollectionReusableView {
        
    static let identifier = "WildPokemonSection"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //background
        if let image = UIImage(named: "tree") {
            backgroundColor = UIColor(patternImage: image)
        }
    }
    
}
