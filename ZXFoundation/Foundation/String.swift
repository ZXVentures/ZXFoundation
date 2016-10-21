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
    public var quotes: String {
        return "\"\(self)\""
    }
    
    /// String with no quotes. Such as defining a type in JSON.
    public var noQuotes: String {
        return self.replace("\"", withString: "")
    }
    
    /// String wrapped in braces. Such as a dictionary.
    public var braces: String {
        return "{\(self)}"
    }
    
    /// String represented without any trailing whitespace.
    public var noTrailingWhitespace: String {
        
        /// Strips whitespace from a string recursively.
        func strip( _ str: String) -> String {
            guard str.characters.last == " " else { return str }
            let str = str.substring(to: str.index(before: str.endIndex))
            guard str.characters.last != " " else { return strip(str) }
            return str
        }
        
        return strip(self)
    }
    
    /// String represented with no spaces.
    public var noSpaces: String {
        return self.replace(" ", withString: "")
    }
    
    /// String escaped for remote queries. 
    /// - note: Original string will be returned if unable to add percent encoding.
    public var escaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    fileprivate func replace(_ string: String, withString new: String, options: NSString.CompareOptions? = nil) -> String {
        return self.replacingOccurrences(of: string, with: new, options: options ?? NSString.CompareOptions.literal, range: nil)
    }
}
