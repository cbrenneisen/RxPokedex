//
//  UIImage.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 1/24/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import UIKit

extension UIImage {
    
    //MARK: Images
    struct Image {
        
        //image shown when pokemon image has not finished downloading
        static var placeholder: UIImage? {
            return UIImage(named: "question-mark")
        }
        
        //section header image
        static var separator: UIImage? {
            return UIImage(named: "tree")
        }
    }
    
    //MARK: Paths
    struct Path {
        
        //gif to show when a pokemon is captured
        static var capturedPokemon: URL? {
            return Bundle.main.url(forResource: "rollingPokeball", withExtension: "gif")
        }
    }
    
}
