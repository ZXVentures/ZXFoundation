//
//  String.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 9/8/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation

extension String {
    
    /// String with no extra " " spaces.
    internal var noSpaces: String {
        return self.stringByReplacingOccurrencesOfString(" ", withString: "")
    }
}
