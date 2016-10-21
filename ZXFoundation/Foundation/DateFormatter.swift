//
//  DateFormatter.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 10/13/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /**
     Creates a US locale DateFormatter with the provided date format.
     
     Helps reduce a lot of boilerplate creating these.
     
     - parameter with: The date format for the date formatter. Ex: "HH:mm"
     - returns: The DateFormatter based on a us locale and a format for the date.
     */
    public static func usLocale(with dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.autoupdatingCurrent
        formatter.dateFormat = dateFormat
        return formatter
    }
}
