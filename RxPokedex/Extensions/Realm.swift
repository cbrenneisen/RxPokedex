//
//  RealmUtility.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/8/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    static func create() -> Realm {
        do { return try Realm() }
        catch let e as NSError {
            fatalError("Failed to create Realm instance: \(e.localizedDescription)")
        }
    }
    
    convenience init?(error: inout PersistenceError?) {
        do { try self.init() }
        catch let e as NSError {
            print("Failed to create Realm instance: \(e.localizedDescription)")
            error = .persistenceIntialization
            return nil
        }
    }

    func write(error: inout PersistenceError?, transaction: ()->Void){
    
        do { try write { transaction() } }
        catch let e as NSError {
            print("Failed to commit Realm transaction: \(e.localizedDescription)")
            error = PersistenceError(from: e)
        }
    }
}
