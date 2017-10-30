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

fileprivate struct API {
    
    private static let limit = 20
    private static let baseURL = "https://pokeapi.co/api/v2/pokemon/"
 
    static func getPokemon(offset: Int) -> URL? {
        
        let urlString = baseURL + "?limit=\(limit)&offset=\(offset)"
        return URL(string: urlString)
    }
    
    static func getPokemonURL(offset: Int) -> String {
        return baseURL + "?limit=\(limit)&offset=\(offset)"
    }
}

final class RemotePokemonManager: RemotePokemonService {
    
    private let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    
    private var manager: SessionManager {
        let configuration = URLSessionConfiguration.default
        let cacheLength = 24 * 60 * 60
        configuration.httpAdditionalHeaders =  ["Cache-Control" : "public, s-maxage=\(cacheLength)"]
        configuration.requestCachePolicy = .returnCacheDataElseLoad //data is unlikely to change
        return Alamofire.SessionManager(configuration: configuration)
    }
    
    private let limit = 20
    private var offset = 0
    private let disposeBag = DisposeBag()
    
    let gatheredPokemon = PublishSubject<[Pokemon]>()
    
    func getInitialPokemon(){
        
    _ = manager.rx.data(.get, API.getPokemonURL(offset: offset))
            .subscribeOn(concurrentScheduler)
            .map({ try JSONDecoder().decode(JSONPokemonResult.self, from: $0).results})
            .map({ pokemon in pokemon.map({ $0.url })})
//            .map({ urls in
//                Observable
//                    .zip(urls.map({ url in
//                        data(.get, url)
//                            .observeOn(concurrentScheduler)
//                    })
//                )
//                .map({ data in try data.map({try JSONDecoder().decode(JSONPokemonDetail.self, from: $0)}) })
//                .map({ jsonData in jsonData.flatMap({( Pokemon(json: $0))}) })
//            })
            .subscribe(onNext: { [unowned self] data in
                self.offset += self.limit
                self.getPokemonDetail(urls: data)
            })
    }
    
    private func getPokemonDetail(urls: [String]){
        
        Observable
            .zip(urls.map({
                url in manager.rx.data(.get, url).subscribeOn(concurrentScheduler)
            }))
            .map({ data in
                try data.map({ try JSONDecoder().decode(JSONPokemonDetail.self, from: $0) })
            })
            .map({ jsonData in
                jsonData.flatMap({( Pokemon(json: $0))})
            })
            .subscribe(onNext: { [unowned self] data in
                self.gatheredPokemon.onNext(data)
            }).disposed(by: disposeBag)
    }
}
