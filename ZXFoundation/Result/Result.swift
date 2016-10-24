//
//  Result.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/21/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 Represents a success with an associated value or an error with an
 associated error value. Should be used in place of Swift's vanilla
 error handling to reduce boilerplate, but can be deconstructed into
 traditional error handling at will.
 
 For example handling a Result of type String:
 
 ```
 switch result {
    case .success(let value): // Do something with the resulting value.
    case .error(let error):   // Do something with the error.
 }
 ```
 */
public enum Result<Value> {
    
    case success(Value)
    case failure(Error)
    
    /// Creates a succesful result with an associated value.
    public init(_ value: Value) { self = .success(value) }
    
    /// Creates a result with an associated error.
    public init(_ error: Error) { self = .failure(error) }
    
    /// Optional value, returned when Self is .success.
    public var value: Value? {
     
        switch self {
        case .success(let value): return value
        case .failure:            return nil
        }
    }
    
    /// Optional error, returned when Self is .error.
    public var error: Error? {
        
        switch self {
        case .success:            return nil
        case .failure(let error): return error
        }
    }
    
    /// Deconstructs the result into a throwable method to
    /// return to Swift error handling.
    public func deconstruct() throws -> Value {
        
        switch self {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }
}
