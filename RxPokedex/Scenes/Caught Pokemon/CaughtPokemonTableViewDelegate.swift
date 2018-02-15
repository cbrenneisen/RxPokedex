//
//  CaughtPokemonTableViewDelegate.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/15/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import UIKit

final class CaughtPokemonTableViewDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.tintColor = .separator
        header.textLabel?.font = UIFont(name: "HelveticaNeue", size: 20.0)
        header.textLabel?.textColor = .white
    }
}
