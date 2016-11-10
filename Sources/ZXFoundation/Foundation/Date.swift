//
//  Date.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/12/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension Date {
    
    /**
     Represents the date as a String in HH:mm format.
     */
    public var hourMinute: String {
        return DateFormatter.usLocale(with: "HH:mm").string(from: self)
    }
    
    /**
     Represents the date in MMMM d, yyyy format.
     */
    public var monthDayYear: String {
        return DateFormatter.usLocale(with: "MMMM d, yyyy").string(from: self)
    }
}

extension Date {
    
    /**
     Creates a Date from a IOS8601 formatted String. Attempts to represent the most
     accurate potrayal of the time given a String. If a dat cannot be created it
     will attempt to pare down the String information and create a partial representation.
     
     - parameter from: The ISO8601 date string: `yyyy-MM-dd'T'HH:mm:ssZZZZZ`
     - returns: The date formatted from the string. Nil if unable to parse.
     */
    public static func iso8601Date(from string: String) -> Date? {
        
        let formats = [
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm",
            "yyyy-MM-dd'T'HH",
            "yyyy-MM-dd",
            "yyyy-MM",
            "yyyy",
        ]
        
        var mutableString = string
        
        for index in 0..<formats.count {
         
            let formatter = DateFormatter.usLocale(with: formats[index])
            
            guard let date = formatter.date(from: mutableString) else {
                
                guard (index + 1) != formats.count else { return nil }
                
                // Make sure we want to strip characters off the string.
                guard mutableString.characters.count > formats[index + 1].characters.count else {
                    continue
                }
                
                // If unable to create from formatted representation, fall back to simpler iso.
                mutableString = mutableString.substring(to: mutableString.index(mutableString.startIndex, offsetBy: formats[index + 1].characters.count - 2))
                continue
            }
            
            return date
        }
        return nil
    }
}
