//
//  NSURLResponse.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 8/29/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension NSURLResponse {

    /// The HTTP status code of the NSURLResponse if applicable.
    public var httpStatus: NSHTTPURLResponse.HTTPStatus? {
        return NSHTTPURLResponse.HTTPStatus((self as? NSHTTPURLResponse)?.statusCode)
    }
}
