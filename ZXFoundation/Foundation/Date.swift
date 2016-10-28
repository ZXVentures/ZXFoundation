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
     Creates a Date from a IOS8601 formatted String. Will return
     a full date including a timezone.
     
     - parameter from: The ISO8601 date string: `yyyy-MM-dd'T'HH:mm:ssZZZZZ`
     - throws: Error if date can't be created from the string.
     - returns: The date formatted from the string.
     */
    public static func iso8601Date(from dateString: String) throws -> Date {
        
        let formatter = DateFormatter.usLocale(with: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        guard let date = formatter.date(from: dateString) else {
            
            // Attempt to fall back before throwing error
            let formatter = DateFormatter.usLocale(with: "yyyy-MM-dd'T'HH:mm:ss")
            guard let date = formatter.date(from: dateString) else {
                
                throw BaseError.unexpectedNil
            }
            return date
        }
        return date
    }
}
