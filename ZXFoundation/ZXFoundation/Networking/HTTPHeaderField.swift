//
//  HTTPHeaderField.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 8/29/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 `HTTPHeaderField` defines a typed representation of applicable HTTP header
 fields.
 */
public enum HTTPHeaderField: String {
    
    /// Accept header field.
    case accept      = "Accept"
    /// Content-Type header field.
    case contentType = "Content-Type"
}
