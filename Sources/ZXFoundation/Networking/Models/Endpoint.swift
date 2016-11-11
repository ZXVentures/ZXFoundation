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
 
 For instance let's say we have a model for photos named `Photo`, which has an
 initializer to transform a network response into this type:
 ```
 public struct Photo {
 
    var id: Int16
    var albumId: Int16
    var title: String
    var url: URL
    var thumbnailUrl: URL
 }
 
 extension Photo {
 
    init(with json: [String: Any]?) throws {
 
        guard let id         = json?["id"] as? Int,
            let albumId      = json?["albumId"] as? Int,
            let title        = json?["title"] as? String,
            let url          = URL(string: json?["url"] as? String ?? ""),
            let thumbnailUrl = URL(string: json?["thumbnailUrl"] as? String ?? "")
            else { throw NetworkError.parse }
 
            self.id           = Int16(id)
            self.albumId      = Int16(albumId)
            self.title        = title
            self.url          = url
            self.thumbnailUrl = thumbnailUrl
        }
    }
 }
 ```
 
 We would then model our `Endpoint`(s) for photos on the `Photo` struct
 as so:
 
 ```
 extension Photo {
 
    static func single(by id: Int16, with baseUrl: URL) throws -> Endpoint<Photo> {
 
        guard let url = URL(string: "photos/\(id)", relativeTo: baseUrl) else {
            throw NetworkError.url
        }
 
        return Endpoint(url: url, parse: { json in
 
            do { return .success(try Photo(with: json as? [String: Any])) }
            catch let error { return .failure(error) }
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
