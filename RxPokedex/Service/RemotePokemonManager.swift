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

final class RemotePokemonManager: RemotePokemonService {
    
    private let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    
    private var manager: SessionManager {
        let configuration = URLSessionConfiguration.default
        let cacheLength = 24 * 60 * 60
        configuration.httpAdditionalHeaders =  ["Cache-Control" : "public, s-maxage=\(cacheLength)"]
        configuration.requestCachePolicy = .returnCacheDataElseLoad //data is unlikely to change
        return Alamofire.SessionManager(configuration: configuration)
    }
    
    private var page = 0
    private let disposeBag = DisposeBag()
    
    let gatheredPokemon = PublishSubject<[Pokemon]>()
    
    func getInitialPokemon(){
        
    _ = manager.rx.data(.get, API.AllPokemon.with(page: 0))
            .subscribeOn(concurrentScheduler)
            .map({ Parse.Pokemon.list(from: $0) })
            .unwrap()
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
                self.page += 1
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
