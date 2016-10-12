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
     Creates a Date from a IOS8601 formatted String. Will return
     a full date including a timezone.
     
     - parameter from: The ISO8601 date string: `yyyy-MM-dd'T'HH:mm:ssZZZZZ`
     - returns:
     */
    static func iso8601Date(from dateString: String) throws -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        guard let date = formatter.date(from: dateString) else { throw BaseError.unexpectedNil }
        return date
    }
}
