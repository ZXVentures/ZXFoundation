//
//  HTTPMethod.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 8/29/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 `HTTPMethod` is a typed representation of a http method for network
 requests. In some cases, the http method may have a associated value.
 
 ## Cases
 
 * `.get` -> **"GET"**
 * `.post` -> **"POST** w/ associated body value.
 * `.put` -> **"PUT** w/ associated body value.
 * `.delete` -> **DELETE**
 */
public enum HTTPMethod<Body> {
    
    case get
    case post(Body)
    case put(Body)
    case delete
}

extension HTTPMethod {
    
    /// String representation of the http method. i.e `.get` -> `GET`
    public var method: String {
        switch self {
        case .get:    return "GET"
        case .post:   return "POST"
        case .put:    return "PUT"
        case .delete: return "DELETE"
        }
    }
    
    /**
     Given a transformative function, associates the Body of data
     with a particular `HTTPMethod`
     */
    public func map<B>(f: (Body) -> B) -> HTTPMethod<B> {
        switch self {
        case .get:            return .get
        case .post(let body): return .post(f(body))
        case .put(let body):  return .put(f(body))
        case .delete:         return .delete
        }
    }
}
