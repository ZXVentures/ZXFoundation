//
//  Compare.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 9/28/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

/**
 Compares two optionals of the same type and returns a `Bool`
 indicating if the left hand side is less than the right hand
 side.
 
 * If both the left hand side and right hand side are `.some`
 a simple comparison of the `.some` values occurs.
 * If the left hand side is `.none` and the right hand side is
 `.some`, left hand side is less than the right hand side.
 * If the right hand side is `.none` and the left hand side is
 `.some` the left hand side is greater than the right hand side.
 * If the left hand side and right hand side are both `.none` then
 the left hand side will be considered greater than the right hand side.
 
 - parameter lhs: The left hand side of the comparison.
 - parameter rhs: The right hand side of the comparison.
 
 - returns: Was the left hand side less than the right.
 */
public func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    
    switch (lhs, rhs) {
      
    case let (lhs?, rhs?): return lhs < rhs
    case (nil, _?):        return true
    case (_?, nil):        return false
    case (nil, nil):       return false
    }
}

/**
 Compares two optionals of the same type and returns a `Bool`
 indicating if the left hand side is greater than the right hand 
 side.
 
 * If both the left hand side and right hand side are `.some`
 a simple comparison of the `.some` values occurs.
 * If the left hand side is `.none` and the right hand side is
 `.some`, left hand side is less than the right hand side.
 * If the right hand side is `.some` and the left hand side is
 `.none` the left hand side is greater than the right hand side.
 * If the left hand side and right hand side are both `.none` then
 the right hand side will be considered greater than the right hand side.
 
 - parameter lhs: The left hand side of the comparison.
 - parameter rhs: The right hand side of the comparison.
 
 - returns: Was the left hand side greater than the right.
 */
public func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    
    switch (lhs, rhs) {
        
    case let (l?, r?): return l > r
    case (nil, _?):    return false
    case (_?, nil):    return true
    case (nil, nil):   return true
    }
}
