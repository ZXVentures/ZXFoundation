//
//  NetworkError.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/10/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 Representative of errors that can propagate from network
 procedures and responses. Implementation is basic to allow
 consumers to extend these errors as they wish.
 */
public enum NetworkError: Error {
    
    /// Ill-formed url.
    case url
    /// Client side error, typically with bad Body data or similar.
    case client
    /// Server side error, resource couldn't be found, etc.
    case server
    /// The request item was not found.
    case notFound
    /// Parsing error.
    case parse
    /// Unknown error.
    case unknown
}
