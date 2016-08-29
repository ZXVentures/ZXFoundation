//
//  Dictionary.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 8/29/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /**
     Returns a dictionary by applying a transorm on a dictionary.
     
     - parameter transform: The transformation.
     - returns: New dictionary after transform.
     */
    public func map<K: Hashable, V>(@noescape transform: (Key, Value) -> (K, V)) -> [K: V] {
        
        var result: [K: V] = [:]
        
        for (key, value) in self {
            let (sameKey, newValue) = transform(key, value)
            result[sameKey] = newValue
        }
        
        return result
    }
}
