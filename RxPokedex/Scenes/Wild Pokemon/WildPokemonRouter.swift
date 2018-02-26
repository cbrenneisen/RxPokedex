//
//  WildPokemonRouter.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/15/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import UIKit
import RxSwift

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

    private var state: WildPokemonState = .hasData
    weak var viewController: UIViewController? {
        didSet {
            //when the view controller is updated, show the appropriate scene
            update(state: state)
        }
    }
        
    func update(state: WildPokemonState){
        self.state = state
        DispatchQueue.main.async {
            switch state {
            case .hasData:
                self.clear()
            case .loading:
                self.setLoading()
            case .error:
                self.setError()
            }
        }
    }
    
    //MARK: - VC Presentations
    
    private func setLoading(){
        viewController?.dismiss(animated: false, completion: nil)
        viewController?.performSegue(withIdentifier: Routes.loading, sender: nil)
    }

    private func setError(){
        //TODO
        viewController?.dismiss(animated: false, completion: nil)
        viewController?.performSegue(withIdentifier: Routes.error, sender: nil)
    }
    
    //MARK: - VC Clean Up
    
    private func clear(){
        //if there is no presented view controller then there is nothing to do
        guard let topVC = viewController?.presentedViewController else { return }
        
        //if we are showing the loading view controller
        if let loadingVC = topVC as? LoadingViewController {
            clearLoading(vc: loadingVC)
        }else {
            viewController?.dismiss(animated: true, completion: nil)
        }
        
        //TODO: handle error VC
    }
    
    private func clearLoading(vc: LoadingViewController){
        vc.set(loading: false)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.viewController?.dismiss(animated: true, completion: nil)
        }
    }
}
