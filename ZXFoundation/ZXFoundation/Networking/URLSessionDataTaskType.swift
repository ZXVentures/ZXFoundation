//
//  URLSessionDataTaskType.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/7/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 A `URLSessionDataTaskType` represents a type that can act as a network
 session data task.
 
 In our case we are using this protocol to wrap NSURLSessionDataTask to
 provide better outlets for mocks and testability.
 */
public protocol URLSessionDataTaskType {
    
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskType { }
