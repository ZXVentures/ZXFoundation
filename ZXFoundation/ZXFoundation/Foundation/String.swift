//
//  String.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 9/8/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension String {
    
    /// String with quotes. Typically used for JSON.
    internal var quotes: String {
        return "\"\(self)\""
    }
    
    /// String with no quotes. Such as defining a type in JSON.
    internal var noQuotes: String {
        return self.replace("\"", withString: "")
    }
    
    /// String wrapped in braces. Such as a dictionary.
    internal var braces: String {
        return "{\(self)}"
    }
    
    fileprivate func replace(_ string: String, withString new: String) -> String {
        return self.replacingOccurrences(of: string, with: new, options: NSString.CompareOptions.literal, range: nil)
    }
}
