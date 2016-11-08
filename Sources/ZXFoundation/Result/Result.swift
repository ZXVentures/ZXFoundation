//
//  Result.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/21/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//
// Borrows heavily from: https://github.com/antitypical/Result
//
// However have amended to use `Swift.Error` exclusively as opposed to NSError
// with a generic type constraint on Result in order to streamline declarations.
// Since we use 100% Swift there's really no need to account for NSError types.
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
}

extension Result {
    
    /// Creates a succesful result with an associated value.
    public init(value: Value) { self = .success(value) }
    
    /// Creates a result with an associated error.
    public init(error: Error) { self = .failure(error) }
    
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

extension Result {
    
    /// Returns a new Result by mapping success values using a transform
    /// or re-wraps error into failure.
    @discardableResult
    public func map<T>(_ transform: (Value) -> T) -> Result<T> {
        
        return flatMap { .success(transform($0)) }
    }
    
    /// Returns the Result of applying a transform to a success value or
    /// the re-wrapped error into failure.
    @discardableResult
    public func flatMap<T>(_ transform: (Value) -> Result<T>) -> Result<T> {
        
        switch self {
        case .success(let value): return transform(value)
        case .failure(let error): return .failure(error)
        }
    }
    
    /// Returns a new Result by mapping failure errors using a transform
    /// or re-wraps values into success.
    @discardableResult
    public func mapError(_ transform: (Error) -> Error) -> Result<Value> {
        
        return flatMapError { .failure(transform($0)) }
    }
    
    /// Returns the Result of applying a transform to a failure error or
    /// the re-wrapped value into success.
    @discardableResult
    public func flatMapError(_ transform: (Error) -> Result<Value>) -> Result<Value> {
        
        switch self {
        case .success(let value): return .success(value)
        case .failure(let error): return transform(error)
        }
    }
}
