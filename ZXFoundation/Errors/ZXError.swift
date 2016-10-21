//
//  ZXError.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/12/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 Base errors for common throwable scenarios. Can be extended at will
 per use case.
 */
public enum BaseError: Error {
    
    case unexpectedNil
}
