//
//  CGRect.swift
//  ZXFoundation
//
//  Created by Wyatt McBain on 9/19/16.
//  Copyright © 2016 ZX Ventures. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {

    /**
     Center point of the CGRect.
     
     `CGRect(0, 0, 100, 100) -> CGPoint(50, 50)`
     
     `CGRect(-50, 0, 100, 100) -> CGPoint(0, 50)`
     
     `CGRect(100, 0, 100, 100) -> CGPoint(150, 50)`
     */
    public var center: CGPoint {
        
        let boundX = origin.x >= 0 ? width : width + origin.x
        let boundY = origin.y >= 0 ? height : height + origin.y
        let x = (origin.x == 0 ? boundX - origin.x : boundX + origin.x) / 2
        let y = (origin.y == 0 ? boundY - origin.y : boundY + origin.y) / 2
        
        return CGPoint(x: x, y: y)
    }
}
