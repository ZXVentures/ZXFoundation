//
//  NSHTTPURLResponse.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 8/29/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension NSHTTPURLResponse {
 
    /**
     `HTTPStatus` provides a typed representation of a http status.
     */
    public enum HTTPStatus {
        
        /// Informational response.
        case info
        /// Succesful response.
        case success
        /// Redirect response.
        case redirect
        /// Response with client side error.
        case clientError
        /// Response with server side error.
        case serverError
        
        /**
         Intialize a status given a status code, even passing in raw status codes.
         */
        public init?(_ rawValue: Int?) {
            guard let statusCode = rawValue else { return nil }
            
            // Ranged cases ftw.
            switch statusCode {
            case 100...199: self = .info
            case 200...299: self = .success
            case 300...399: self = .redirect
            case 400...499: self = .clientError
            case 500...599: self = .serverError
            default: return nil
            }
        }
    }
}
