//
//  CGRectTests.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 11/10/16.
//  Copyright © 2016 ZX VENTURES LLC. All rights reserved.
//

import XCTest
@testable import ZXFoundation

class CGRectTests: XCTestCase {
    
    func testCenter() {
        
        let rect200x200 = CGRect(x: 0, y: 0, width: 200, height: 200)
        let rect200x200Expected = CGPoint(x: 100, y: 100)
        
        XCTAssertEqual(rect200x200.center, rect200x200Expected)
        
        let rect300x200 = CGRect(x: 0, y: 0, width: 300, height: 200)
        let rect300x200Expected = CGPoint(x: 150, y: 100)
        
        XCTAssertEqual(rect300x200.center, rect300x200Expected)
        
        let offsetNegXRect200x200 = CGRect(x: -100, y: 0, width: 200, height: 200)
        let offsetNegXRect200x200Expected = CGPoint(x: 0, y: 100)
        
        XCTAssertEqual(offsetNegXRect200x200.center, offsetNegXRect200x200Expected)
        
        let offsetPosXRect200x200 = CGRect(x: 100, y: 0, width: 200, height: 200)
        let offsetPosXRect200x200Expected = CGPoint(x: 150, y: 100)
        
        XCTAssertEqual(offsetPosXRect200x200.center, offsetPosXRect200x200Expected)
        
        let offsetNegYRect200x200 = CGRect(x: 0, y: -100, width: 200, height: 200)
        let offsetNegYRect200x200Expected = CGPoint(x: 100, y: 0)
        
        XCTAssertEqual(offsetNegYRect200x200.center, offsetNegYRect200x200Expected)
        
        let offsetPosYRect200x200 = CGRect(x: 0, y: 100, width: 200, height: 200)
        let offsetPosYRect200x200Expected = CGPoint(x: 100, y: 150)
        
        XCTAssertEqual(offsetPosYRect200x200.center, offsetPosYRect200x200Expected)
        
        let zeroRect = CGRect.zero
        let zeroRectExpected = CGPoint.zero
        
        XCTAssertEqual(zeroRect.center, zeroRectExpected)
    }
}
