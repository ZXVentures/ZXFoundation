//
//  HTTPMethod.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 8/29/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 `HTTPMethod` defines a typed representation of a http method.
 */
public enum HTTPMethod: String {
    
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}
