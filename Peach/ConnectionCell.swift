//
//  ConnectionCell.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ConnectionCell: NSView {

    var bottomBorder: NSBezierPath?
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        if let l = layer {

            NSColor(calibratedHue:0, saturation:0, brightness:0.90, alpha:1).setStroke()
            
            bottomBorder = NSBezierPath(rect: CGRect(x: 78, y: 0, width: l.frame.size.width-78, height: 0))
            bottomBorder?.lineWidth = 1
            bottomBorder?.stroke()
            
            l.backgroundColor = NSColor.whiteColor().CGColor
            
        }
        
    }
    
}
