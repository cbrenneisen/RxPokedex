//
//  LoadingViewModel.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoadingViewModel: RemotePokemonServiceInjected {
    
    var title: Observable<String>{
        return loading.map({ $0 ? "Looking for Pokemon" : "Found Pokemon!" })
    }
    
    let loading = BehaviorSubject<Bool>(value: true)

    func set(loading: Bool){
        self.loading.onNext(loading)
    }
    
}
