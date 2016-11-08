//
//  Networker.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/10/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 Flexible and securable network client for loading network requests that are
 modeled with an `Endpoint<T>`.
 
 To test or mock network requests provide the `Networker` with a custom 
 `URLSessionType` which will allow you to return custom responses.
 
 To have the `Networker` pin SSL provide it with a certificate in `Data`
 format.
 
 - seealso: `Endpoint<T>`
 */
public final class Networker: NSObject {
    
    /// The default URLSession when a custom session is not configured.
    fileprivate lazy var defaultSession: URLSessionType = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    /// Definable session for customization, testing, and mocks.
    fileprivate let customSession: URLSessionType?
    
    /// The `URLSessionType` being utilized for network requests.
    fileprivate var session: URLSessionType {
        guard let session = customSession else { return defaultSession }
        return session
    }
    
    /// The `Credential` to verify the server's authenticity.
    fileprivate let credential: Credential?
    
    /**
     Default initializer.
     
     - parameter credential: The credential to use to verify the server's authenticity.
     **Note:**  Leaving this blank means that all requests will be
     accepeted without verifying the server's identity.
     - parameter session: A custom session. A good way to test network
     requests.
     */
    public init(credential: Credential? = nil, session: URLSessionType? = nil) {
        
        self.credential = credential
        customSession   = session
    }
    
    /**
     Loads a given `Endpoint<T>` resource and calls a completion handler
     based on the completion of the request and parsing of the
     endpoint.
     
     - parameter endpoint: The `Endpoint<T>` to be loaded.
     - parameter completion: The completion handler which returns the
     parsed endpoint type `T` and an error if present.
     
     - seealso: `Endpoint<T>`
     */
    public func load<T>(_ endpoint: Endpoint<T>, completion: @escaping (Result<T>) -> ()) {
        
        // Create a session, initializing the `URLRequest` with the
        // given endpoint.
        session.dataTask(with: URLRequest(endpoint: endpoint)) { data, response, _ in
            
            let status = HTTPStatus((response as? HTTPURLResponse)?.statusCode)
            
            // break early if data doesn't exist or request is unsuccessful
            guard let data = data,
                status == .success
                else { completion(.failure(status.error)); return }
            
            completion(endpoint.parse(data))
            
        }.resume()
    }
}

extension Networker: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust,
            let serverCert = SecTrustGetCertificateAtIndex(serverTrust, 0)
            else {
                
                // NOTE: Unsure if we should inject error handling here, leaving for now.
                // If added, error handler should probably be attributed on the networker.
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
        }
            
        // Create server credential
        let serverCredential = URLCredential(trust: serverTrust)
        
        // Only continue if local cert data is set for comparison
        guard let credential = credential else {
            
            // NOTE: If you're relying on this you should probably just stop. Sad!
            completionHandler(.useCredential, serverCredential)
            return
        }
        
        // Pin the server
        credential.pin(challenge: challenge, serverTrust: serverTrust, serverCert: serverCert, serverCredential: serverCredential, completion: completionHandler)
    }
}
