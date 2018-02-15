//
//  PersistenceError.swift
//  RxPokedex
//
//  Created by Carl Brenneisen on 2/8/18.
//  Copyright © 2018 carl.brenneisen. All rights reserved.
//

import Foundation


enum PersistenceError: Error {
    case persistenceIntialization   //cant create realm object
    case invalidInput               //could not attempt task due to bad information
    case recordNotFound             //critical record not found
    case outOfMemory                //user's memory is at capacity
    case notAuthorized              //app is in background with encryption / phone not unlocked
    case unknown                    //any error not meeting the above conditions
    
    init(from: NSError){
        self = Utility.Adapter.persistenceError(from: from)
    }
    
    var description: String {
        switch self {
        case .persistenceIntialization:
            return "Had trouble accessing internal database"
        case .invalidInput:
            return "Input not supported"
        case .recordNotFound:
            return "Record not found"
        case .outOfMemory:
            return "Could not save due to low memory - check your phone's available storage"
        case .notAuthorized:
            return "Access Restricted"
        case .unknown:
            return "An unknown error occurred"
        }
    }
    
}

fileprivate struct Utility {
    
    struct Adapter {
        private static let ePerm = Int(EPERM)
        private static let eAcces = Int(EACCES)
        private static let eNomem = Int(ENOMEM)

        static func persistenceError(from: NSError) -> PersistenceError {
            switch(from.domain){
            case NSPOSIXErrorDomain:
                return translate(posix: from)
            case NSCocoaErrorDomain:
                return translate(cocoa: from)
            default:
                return .unknown
            }
        }
        
        private static func translate(posix: NSError) -> PersistenceError {
            switch posix.code {
            case ePerm, eAcces:
                return .notAuthorized
            case eNomem:
                return .outOfMemory
            default:
                return .unknown
            }
        }
        
        private static func translate(cocoa: NSError) -> PersistenceError {
            switch cocoa.code {
            case NSFileReadNoPermissionError, NSFileWriteNoPermissionError, NSURLErrorNoPermissionsToReadFile, NSCloudSharingNoPermissionError:
                return .notAuthorized
            case NSFileWriteOutOfSpaceError, NSBundleOnDemandResourceOutOfSpaceError:
                return .outOfMemory
            default:
                return .unknown
            }
        }
    }
}
