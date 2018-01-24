//
//  UIImage.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 1/24/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import UIKit

extension UIImage {
    
    static var placeholder: UIImage {
        return UIImage(named: "question-mark") ?? UIImage()
    }
}
