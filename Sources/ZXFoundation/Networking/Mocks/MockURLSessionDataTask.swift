//
//  MockURLSessionDataTask.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/25/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 Provides outlets for mocks/testing a URLSessionDataTaskType. Intentionally
 left open and without additional logic within `resume` as it's unlikely
 that we need to test if `resume` was called but still need this shim
 to implement `MockURLSession`. 
 
 If you want to test whether `resume` was called simply override this default
 implementation and include the mock `URLSessionDataTaskType` into the initializer
 provided for `MockURLSession`.
 */
open class MockURLSessionDataTask: URLSessionDataTaskType {
    
    open func resume() {}
}
