//
//  RemotePokemonManager.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 10/28/17.
//  Copyright © 2017 carl.brenneisen. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import RxSwiftExt

fileprivate struct RxSession {
    
    static var session: URLSession {
        let configuration = URLSessionConfiguration.default
        let cacheLength = 24 * 60 * 60
        configuration.httpAdditionalHeaders =  ["Cache-Control" : "public, s-maxage=\(cacheLength)"]
        configuration.requestCachePolicy = .returnCacheDataElseLoad //data is unlikely to change
        return URLSession(configuration: configuration)
    }
    
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
    
    var wildPokemon: Observable<[WildPokemon]> { return _wildPokemon }
    private var _wildPokemon = PublishSubject<[WildPokemon]>()
    
    /**
        Initiates a request to get Pokemon from the server
     
        - parameter page: The offset for which to start searching for Pokemon
     */
    func requestPokemon(page: Int) {
        // - fetch the data for the corresponding offset from the server
        // - parse the result into Pokemon objects
        // - filter out nils
        
        _ = RxSession.manager.rx.data(.get, API.AllPokemon.with(page: page))
            .subscribeOn(RxSession.scheduler)
            .map({ Parse.Pokemon.Summary.list(from: $0) })
            .unwrap()
            .subscribe(onNext: { [weak self] pokemon in
                // - get extra information for the returned pokemon
                self?.process(pokemon: pokemon)
            }, onError: { [weak self] error in
                // - pass along errors
                self?._wildPokemon.onError(error)
            })
    }
    
    /**
       Fetch and emit additional data for a list of Pokemon
     
        - parameter pokemon: An array of JSON objects with light information for different Pokemon
     */
    private func process(pokemon: [JSONPokemon]){
        // - fetched detailed information for each pokemon, using the detail url
        // - for each response from the server, parse the json dictionary, removing nil entries
        // - convert each json dictionary into a custom Pokemon object
        _ = Observable
            .zip(pokemon.map({ RxSession.manager.rx.data(.get, $0.url)}))
            .map({ $0.compactMap({ Parse.Pokemon.Detail.single(from: $0) })})
            .map({ $0.compactMap({( WildPokemon(json: $0))}) })
            .subscribe(onNext: { [weak self] poke in
                /// - pass along data
                self?._wildPokemon.onNext(poke)
            }, onError: { [weak self] error in
                /// - pass along errors
                self?._wildPokemon.onError(error)
            })
    }
}
