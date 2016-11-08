//
//  Credential.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 11/7/16.
//  Copyright © 2016 ZX VENTURES LLC. All rights reserved.
//

import Foundation

/**
 Hosts SSL credential information for use in a `Networker` to pin a
 server's certificate or public key. Since we are using `Data` as
 the comparison container we can hash whatever we are comparing
 to validate the server's authenticity.
 
 For example if you wanted to pin the server's certificate and the certificate
 data was hosted locally you would create a Credential as so:
 ```
 let credential = Credential(data: Data(), certify: { challenge, serverTrust, serverCert, data in
 
    let policies = NSMutableArray()
    policies.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString?))
    SecTrustSetPolicies(serverTrust, policies)
 
    var result = SecTrustResultType.invalid
    SecTrustEvaluate(serverTrust, &result)
 
    let serverIsTrusted = result == .unspecified || result == .proceed
 
    let serverData = SecCertificateCopyData(serverCert) as Data
 
    guard serverIsTrusted, serverData.elementsEqual(data) else {
 
        return .cancelAuthenticationChallenge
    }
 
    return .useCredential
 })
 ```
 
 - note: A lot more testing is necessary before this could be included in
 production.
 */
public struct Credential {
    
    /// The locally hosted data to compare against the server's.
    public let data: Data
    
    /// Procedure to verify the server data vs the locally hosted data.
    public let certify: (URLAuthenticationChallenge, SecTrust, SecCertificate, Data) -> (URLSession.AuthChallengeDisposition)
    
    public init(data: Data, certify: @escaping (URLAuthenticationChallenge, SecTrust, SecCertificate, Data) -> (URLSession.AuthChallengeDisposition)) {
        
        self.data    = data
        self.certify = certify
    }
    
    /**
     Pins the server with the provided hosted data and the one retrieved from
     the server information provided.
     
     - parameter challenge: The challenge from the server.
     - parameter serverTrust: Server's SSL transaction state.
     - parameter serverCert: The certificate pulled from the server's certificate chain.
     - parameter serverCredential: Credential for server trust authorization.
     - parameter completion: Completion handler forwarded from `URLSessionDelegate`
     */
    public func pin(challenge: URLAuthenticationChallenge, serverTrust: SecTrust, serverCert: SecCertificate, serverCredential: URLCredential, completion: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completion(certify(challenge, serverTrust, serverCert, data), serverCredential)
    }
}
