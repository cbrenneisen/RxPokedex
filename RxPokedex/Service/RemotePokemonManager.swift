//
//  RemotePokemonManager.swift
//  RxPokedex
//
//  Created by Carlos Brenneisen on 10/28/17.
//  Copyright © 2017 carlos.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import RxSwiftExt
import RxCocoa

fileprivate struct RxSession {
    static var manager: SessionManager {
        let configuration = URLSessionConfiguration.default
        let cacheLength = 24 * 60 * 60
        configuration.httpAdditionalHeaders =  ["Cache-Control" : "public, s-maxage=\(cacheLength)"]
        configuration.requestCachePolicy = .returnCacheDataElseLoad //data is unlikely to change
        return Alamofire.SessionManager(configuration: configuration)
    }
    
    static var scheduler: ConcurrentDispatchQueueScheduler {
        return ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    }
}

final class RemotePokemonManager: RemotePokemonService {
    
    private let disposeBag = DisposeBag()
    
    var wildPokemon: Observable<[Pokemon]> {
        return gatheredPokemon
                .map({ Observable.zip($0.map({ RxSession.manager.rx.data(.get, $0.url)})) })
                .flatMap({ $0 })
                .map({ $0.flatMap({ Parse.Pokemon.Detail.single(from: $0) })})
                .map({ $0.flatMap({( Pokemon(json: $0))}) })
    }
    
    private var gatheredPokemon = PublishSubject<[JSONPokemon]>()
    
    func requestPokemon(page: Int){
        _ = RxSession.manager.rx.data(.get, API.AllPokemon.with(page: page))
            .subscribeOn(RxSession.scheduler)
            .map({ Parse.Pokemon.Summary.list(from: $0) })
            .unwrap()
            .bind(to: gatheredPokemon)
    }
}
