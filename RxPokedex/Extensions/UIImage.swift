//
//  UIImage.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/24/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import UIKit

extension UIImage {
    
    //MARK: Images
    struct Image {
        static var placeholder: UIImage? {
            return UIImage(named: "question-mark")
        }
        
        static var separator: UIImage? {
            return UIImage(named: "tree")
        }
    }
    
    //MARK: Paths
    struct Path {
        static var capturedPokemon: URL? {
            return Bundle.main.url(forResource: "rollingPokeball", withExtension: "gif")
        }
    }
    
}
