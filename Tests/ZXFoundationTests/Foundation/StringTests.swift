//
//  StringTests.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 11/10/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import XCTest

class StringTests: XCTestCase {
    
    func testReplacedAttributes() {
        
        let starting = "hello, world       "
        
        XCTAssertEqual(starting.quotes, "\"\(starting)\"")
        
        XCTAssertEqual("\"\(starting)\"".noQuotes, starting)
        
        XCTAssertEqual(starting.braces, "{\(starting)}")
        
        XCTAssertEqual(starting.noTrailingWhitespace, "hello, world")
        
        XCTAssertEqual(starting.noSpaces, "hello,world")
        
        XCTAssertEqual(starting.noTrailingWhitespace.escaped, "hello,%20world")
        
        XCTAssertEqual("hello".escaped, "hello")
    }
    
    func testRegexMatch() {
        
        let reference = "hello and welcome to my swift tests"
        
        XCTAssertTrue(reference.hasMatch(for: "hello"))
        
        XCTAssertTrue(reference.hasMatch(for: ["not", "swift"]))
        
        XCTAssertFalse(reference.hasMatch(for: "not"))
        
        XCTAssertFalse(reference.hasMatch(for: ["not", "nor"]))
    }
    
    func testRandom() {
        
        XCTAssertTrue(String.random(length: 4).characters.count == 4)
        
        XCTAssertTrue(String.random(length: 0).characters.count == 0)
        
        XCTAssertTrue(String.random(length: -2).characters.count == 0)
    }
}
