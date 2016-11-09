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
     Center point of the CGRect frame.

     Determined by the min and max values of the x and y axis.

     ```
     CGPoint(x: (maxX - minX) / 2, y: (maxY - minY) / 2)
     ```
     */
    public var center: CGPoint {
        return CGPoint(x: (maxX - minX) / 2, y: (maxY - minY) / 2)
    }
}
