//
//  String.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 9/8/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

// MARK: Replacements
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

// MARK: Regular Expression
extension String {
    
    /**
     Convenience to test if the String has a match for a given regular expression.
     
     - parameter for: The regex to search for.
     - returns: Was a match found.
     */
    public func hasMatch(for regex: String) -> Bool {
        guard let range = self.range(of: regex, options: .regularExpression) else { return false }
        return !range.isEmpty
    }
    
    /**
     Convenience to test if the String has a match for one of the given regular
     expressions in the array provided.
     
     - parameter for: The array of regex String to try and match.
     - returns: Was a match found for one of the provided regex Strings.
     */
    public func hasMatch(for regexArray: [String]) -> Bool {
        for regex in regexArray {
            if self.hasMatch(for: regex) { return true }
        }
        return false
    }
}

// MARK: Randomization
extension String {
    
    /**
     Creates a random `String` with a provided length.
     
     - parameter length: The desired length of the random String.
     - returns: The random `String` with the appropriate length.
     */
    public static func random(length: Int8) -> String {
        
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let lettersLength = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0..<length {
            let rand = arc4random_uniform(lettersLength)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
