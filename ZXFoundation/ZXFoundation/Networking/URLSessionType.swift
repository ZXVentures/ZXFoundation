//
//  URLSessionType.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/7/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 A `URLSessionType` represents a type that can act as a url session.
 
 In our case we are using this protocol to wrap NSURLSession, which allows
 us to mock the network layer of our service. This gives us a lot of
 flexibility and enables us to provide a more robust test suite.
 */
public protocol URLSessionType {
    
    /// Data request with a completion handler.
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskType
}

extension URLSession: URLSessionType {
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskType {
        
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskType
    }
}
