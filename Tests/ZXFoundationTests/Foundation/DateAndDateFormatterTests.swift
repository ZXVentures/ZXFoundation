//
//  DateAndDateFormatterTests.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 11/10/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import XCTest

class DateAndDateFormatterTests: XCTestCase {
    
    func testDateAttributes() {
        
        let current = Date()
        
        XCTAssertTrue(current.hourMinute.hasMatch(for: "^\\d{2}:\\d{2}$"))
        
        XCTAssertTrue(current.monthDayYear.hasMatch(for: "^\\w*? \\w*?, \\d{4}$"))
    }
    
    func testISODate() {
        
        let validStrings = [
            "2016-02-24T22:08:06.000Z",
            "2016-11-04T11:04:12-04:00",
            "2016-11-04T11:04:12-04",
            "2016-11-04T11:04:12",
            "2016-11-04T11:04",
            "2016-11-04T11",
            "2016-11-04",
            "2016-11",
            "2016"
        ]
        
        for string in validStrings {
            
            XCTAssertNotNil(Date.iso8601Date(from: string))
        }
    }
}
