//
//  ViewController.swift
//  RxPokedex
//
//  Created by carlos.brenneisen on 2/28/18.
//  Copyright © 2018 carlos.brenneisen. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //whether the current view controller is at the top of the navigation stack
    var isTopViewController: Bool {
        guard let navC = navigationController else { return false }
        guard let topVC = navC.topViewController else { return false }
        
        //check if the top view controller is the same as this one
        return topVC == self
    }
}
