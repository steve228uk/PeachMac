//
//  NSColor+CustomColors.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension NSColor {
    
    class func peachBackgroundColor() -> NSColor {
        return NSColor(calibratedHue:0.07, saturation:0.09, brightness:0.99, alpha:1)
    }
    
    class func peachBorderColor() -> NSColor {
        return NSColor(calibratedHue:0.07, saturation:0.08, brightness:0.94, alpha:1)
    }
    
    class func peachGreyColor() -> NSColor {
        return NSColor(calibratedHue:0, saturation:0, brightness:0.90, alpha:1)
    }
    
}