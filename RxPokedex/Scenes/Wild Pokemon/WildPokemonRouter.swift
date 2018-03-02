//
//  WildPokemonRouter.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/15/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

fileprivate struct Routes {
    
    static let loading = "LoadingSegue"
    static let error = "ErrorSegue"
}

enum WildPokemonState {
    
    case hasData
    case loading
    case error
    
    init(loading: Bool, error: Bool){
        //error takes priority, then loading, then hasData
        self = error ? .error : (loading ? .loading : .hasData)
    }
}

final class WildPokemonRouter {
    
    //MARK: - exposed variables

    var state: WildPokemonState = .loading {
        didSet {
            set(state: state)
        }
    }
    
    weak var viewController: WildPokemonViewController? {
        didSet {
            set(state: state)
        }
    }
    
    //MARK: - VC Presentations
    private func set(state: WildPokemonState){
        guard let vc = viewController else { return }
        
        DispatchQueue.main.async {
            switch state {
            case .error:
                self.setError(vc: vc)
            case .loading:
                self.setLoading(vc: vc)
            case .hasData:
                self.clear(vc: vc)
            }
        }
    }
    
    private func setLoading(vc: UIViewController){
        clear(vc: vc)
        vc.performSegue(withIdentifier: Routes.loading, sender: nil)
    }

    private func setError(vc: UIViewController){
        clear(vc: vc)
        vc.performSegue(withIdentifier: Routes.error, sender: nil)
    }
    
    //MARK: - VC Clean Up
    private func clear(vc: UIViewController){
        guard !vc.isTopViewController else { return }
        
        //if this is NOT the top view controller, then dismiss whatever is on top
        vc.navigationController?.popViewController(animated: true)
    }
}
