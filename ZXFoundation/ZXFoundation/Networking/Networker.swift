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
    fileprivate var customSession: URLSessionType?
    
    /// The `URLSessionType` being utilized for network requests.
    fileprivate var session: URLSessionType {
        guard let session = customSession else { return defaultSession }
        return session
    }
    
    /**
     If present the networker will pin the server's ssl certificate
     to the data provided, to ensure that the connection to the
     server is private.
     */
    fileprivate var cert: Data?
    
    /**
     Default initializer.
     
     - parameter certificate: The ssl certificate data to pin the server.
     **Note:**  Leaving this blank means that all requests will be
     accepeted without verifying the server's identity.
     - parameter session: A custom session. A good way to test network
     requests.
     */
    public init(certificate cert: Data? = nil, session: URLSessionType? = nil) {
        
        self.cert     = cert
        customSession = session
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
    public func load<T>(_ endpoint: Endpoint<T>, completion: @escaping (T?, Error?) -> ()) {
        
        // Create a session, initializing the `URLRequest` with the
        // given endpoint.
        session.dataTask(with: URLRequest(endpoint: endpoint)) { data, response, _ in
            
            let status = HTTPStatus((response as? HTTPURLResponse)?.statusCode)
            
            // break early if network request is unsuccesful
            guard status == .success else {
                completion(nil, status.error)
                return
            }
            
            // attempt to parse.
            do {
                let item = try data.flatMap(endpoint.parse)
                completion(item, nil)
            } catch let error {
                completion(nil, error)
            }
            
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
        let credential = URLCredential(trust: serverTrust)
        
        // Only continue if local cert data is set for comparison
        guard let cert = cert else {
            
            // NOTE: If you're relying on this you should probably just stop. Sad!
            completionHandler(.useCredential, credential)
            return
        }
        
        // Set policies
        let policies = NSMutableArray()
        policies.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString?))
        SecTrustSetPolicies(serverTrust, policies)
        
        // Evaluate server certificate
        var result = SecTrustResultType.invalid
        SecTrustEvaluate(serverTrust, &result)
        
        let serverIsTrusted = result == .unspecified || result == .proceed
        
        let serverData = SecCertificateCopyData(serverCert) as Data
        
        // Evaluate
        guard serverIsTrusted, serverData.elementsEqual(cert) else {
            
            // Server is very very suspicious
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // Succesful pin
        completionHandler(.useCredential, credential)
    }
}
