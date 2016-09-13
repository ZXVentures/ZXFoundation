//
//  NSURLResponse.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 8/29/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension URLResponse {

    /// The HTTP status code of the NSURLResponse if applicable.
    public var httpStatus: HTTPStatus? {
        return HTTPStatus((self as? HTTPURLResponse)?.statusCode)
    }
}
