//
//  UIColor.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/29/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import UIKit

extension UIColor {
    
    //MARK: - Common Colors
    class var navColor: UIColor {
        return gray(shade: 31)
    }
    
    class var separator: UIColor {
        return gray(shade: 50)
    }
    
    //MARK: - Helpers
    private static func gray(shade: Float, alpha: Double = 1.0) -> UIColor {
        let color = CGFloat(Float(shade)/Float(255.0))
        return UIColor(red: color, green: color, blue: color, alpha: 1.0)
    }
}
