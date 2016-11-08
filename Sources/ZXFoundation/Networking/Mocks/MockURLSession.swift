//
//  MockURLSession.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/25/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 Provides an outlet for mocks and/or testing where there is a networking component
 that allows for a settable `URLSessionType`. This allows us to take our tests/mocks
 offline and provide custom responses to be returned to the consumer of the URLSessionType.
 
 This mock session assumes that we will be loading the response from a file within
 our current bundle, as such it's required to create this session is a `MockResource`
 that defines the file name and the type of file to be loaded. Without any other
 parameters set upon initialization the data task will return a status code of 200
 and the response loaded from the file as Data.
 
 It is also possible to define a HTTPStatus code and header fields to be included in the
 HTTPURLResponse. Please note that setting the status code will return the first integer
 in the status code's range. For instance a .success will include a 200 in the HTTPURLResponse 
 returned from the data task.
 */
open class MockURLSession: URLSessionType {
    
    /// Resource to be loaded from the Bundle.
    private var resource: MockResource
    
    /// The status code to be reported in the HTTPURLResponse.
    private var statusCode: HTTPStatus
    
    /// The header fields to be reported in the HTTPURLResponse.
    private var headerFields: [String : String]?
    
    /// The data task that resume will be called upon.
    private var dataTask: URLSessionDataTaskType
    
    /// Data representation of the resource loaded from the Bundle.
    private var data: Data? {
        let bundle = Bundle(identifier: resource.bundleIdentifier)
        guard let file = bundle?.path(forResource: resource.name, ofType: resource.type.rawValue) else { return nil }
        return (try? Data(contentsOf: URL(fileURLWithPath: file)))
    }
    
    /**
     Creates a `MockURLSession` with a provided `MockResource` allowing us to return
     responses loaded from the resource to networking providers who allow a custom URLSessionType.
     
     - parameter mockResource: The `MockResource` to be loaded from the bundle.
     - parameter statusCode: When provided, will include the first integer in the status code's range
     in the HTTPURLResponse provided in the completion of the URLSessionType data task.
     - parameter headerFields: When provided includes the header fields in the HTTPURLResponse
     provided in the completion handler URLSessionType data task.
     - parameter mockDataTask: When provided this URLSessionDataTask type will be used in place
     of the default `MockURLSessionDataTaskType`.
     */
    public init(mockResource resource: MockResource, statusCode: HTTPStatus? = nil, headerFields: [String: String]? = nil, mockDataTask dataTask: URLSessionDataTaskType? = nil) {
        
        self.resource     = resource
        self.statusCode   = statusCode ?? .success
        self.headerFields = headerFields
        self.dataTask     = dataTask ?? MockURLSessionDataTask()
    }
    
    /**
     Creates a `URLSessionDataTaskType` that provides the response loaded from the MockResource in
     the completion handler.
     */
    open func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskType {
        
        let response = HTTPURLResponse(url: URL(string: "http://www.zx-ventures-ftw.com")!, statusCode: statusCode.mockStatus, httpVersion: nil, headerFields: headerFields)
        
        // Completion handler returns a notFound NetworkError if resource could not be loaded.
        if let data = data { completionHandler(data, response, nil) }
        else { completionHandler(nil, nil, NetworkError.notFound); }
        
        return dataTask
    }
}

extension HTTPStatus {
    
    /// Provides the first integer in the status code's range.
    fileprivate var mockStatus: Int {
        
        switch self {
        case .info:        return 100
        case .success:     return 200
        case .redirect:    return 300
        case .clientError: return 400
        case .serverError: return 500
        default:           return 0
        }
    }
}
