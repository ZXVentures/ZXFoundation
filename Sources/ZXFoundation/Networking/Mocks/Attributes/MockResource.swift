//
//  MockResource.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/25/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 Defines a resource that will be used for mocks and testing.
 This is currently used within a `MockURLSession` to provide
 a reusable way to define various resources to be loaded from
 the bundle.
 
 For instance let's say we had a variety of json files we would
 like to load for a suite of tests. We'd define a entity conforming
 to this type in order to associate a resource with file name, content
 type and bundle identifier.
 
 ```
 enum MockResponses: MockResource {
 
    case authEmail
    case login
 
    var name: String {
        switch self {
        case .authEmail: return "auth-email"
        case .login:     return "login"
        }
    }
 
    var type: ResourceContentType {
        return .json
    }
 
    var bundleIdentifier: String {
        return "com.zx-ventures.frameworks.ShopKit"
    }
 }
 ```
 
 We could then load the resource from the Bundle as such:
 
 ```
 let authEmail = MockResponses.authEmail
 let authJson = Bundle.mainBundle().path(forResource: authEmail.name, ofType: authEmail.type.rawValue)
 ```
 */
public protocol MockResource {
    
    /// The file name of the resource.
    var name: String { get }
    
    /// The file type for the resource.
    var type: ResourceContentType { get }
    
    /// The bundle identifier of the target the resource belongs to.
    var bundleIdentifier: String { get }
}
