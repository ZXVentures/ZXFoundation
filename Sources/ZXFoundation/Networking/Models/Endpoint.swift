//
//  Endpoint.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/10/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//
// Borrows heavily from: https://talk.objc.io/episodes/S01E01-networking
//

import Foundation

/**
 Represents a remote network resource with an associated type.
 
 By defining a `URL`, `HTTPMethod`, and a `(Data) throws -> Type?`
 parsing method to interact with the endpoint, we are able to transform
 the endpoint into a concrete type quite easily.
 
 **Example:**
 
 For instance let's say we have a model for photos named `Photo`:
 ```
 public struct Photo {
 
    var id: Int16
    var albumId: Int16
    var title: String
    var url: URL
    var thumbnailUrl: URL
 }
 ```
 
 We would then model our `Endpoint`(s) for photos on the `Photo` struct
 as so:
 
 ```
 extension Photo {
 
    static func all(with baseUrl: URL) throws -> Endpoint<[Photo]> {
 
        guard let url = URL(string: "photos", relativeTo: baseUrl) else { throw NetworkError.url }
 
        return Endpoint(url: url, parse: { json throws in
 
            guard let jsonArray = json as? [[String: Any]] else { throw NetworkError.parse }
 
            do {
 
                var photos = [Photo]()
                for json in jsonArray {
                    try photos.append(Photo(with: json))
                }
                return photos
            }
        })
    }
 }
 ```
 
 Used in conjuction with a network client and initializers, this pattern
 becomes quite useful and attempts to simpligy how we interact with
 network side requests.
 */
public struct Endpoint<T> {
    
    /// The absolute url for the endpoint.
    public let url: URL
    
    /// The HTTPMethod of the endpoint request.
    public let method: HTTPMethod<Data>
    
    /// The HTTP header fields `Key: Value` to be sent with the request.
    public let headerFields: [String: String]?
    
    /// The parse method of the endpoint which transforms it into
    /// a concrete type.
    public let parse: (Data) -> Result<T>
}

extension Endpoint {
    
    /**
     Initializer for an `Endpoint` when the both the HTTPMethod body
     is json transformed into data and when parsing occurs on a json
     object.
     
     - parameter url: Full path url for the endpoint.
     - parameter method: The http method the endpoint expects.
     - parameter headerFields: Optional header fields to be included with
     the `URLRequest`.
     - parameter parse: The parsing function that transforms the
     endpoint into a concrete type.
     */
    public init(url: URL, method: HTTPMethod<Any> = .get, headerFields: [String: String]? = nil, parse: @escaping (Any) -> Result<T>) {
        
        self.url = url
        
        self.method = method.map { json in
            
            // Assumption is here that json being inserted as body will always be
            // well formed. This will cause a fatal crash if the json is bad.
            try! JSONSerialization.data(withJSONObject: json)
        }
        
        self.headerFields = headerFields
        
        self.parse = {
            do { return parse(try JSONSerialization.jsonObject(with: $0)) }
            catch { return .failure(NetworkError.parse) }
        }
    }
}
