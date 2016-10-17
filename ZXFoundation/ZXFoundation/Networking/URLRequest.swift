//
//  URLRequest.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/10/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension URLRequest {
    
    /**
     Constructs an URLRequest given a Endpoint.
     
     - parameter endpoint: The endpoint to be represented as a
     `URLRequest`.
     */
    public init<T>(endpoint: Endpoint<T>) {
        self.init(url: endpoint.url)
        
        httpMethod = endpoint.method.method
        
        if let headerFields = endpoint.headerFields {
            
            for key in headerFields.keys {
                guard let value = headerFields[key] else { continue }
                addValue(value, forHTTPHeaderField: key)
            }
        }
        
        httpBody = {
            switch endpoint.method {
            case .get,
                 .delete:         return nil
            case .post(let body): return body
            case .put(let body):  return body
            }
        }()
    }
}
