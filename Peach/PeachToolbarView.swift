//
//  PeachToolbarView.swift
//  Peach
//
//  Created by Stephen Radford on 24/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachToolbarView: NSView {

    var bottomBorder: NSBezierPath?
    
    var showBorder = true
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.whiteColor().CGColor
        
        if showBorder {
            if let l = layer {
                
                NSColor(calibratedHue:0, saturation:0, brightness:0.79, alpha:1).setStroke()
                bottomBorder = NSBezierPath(rect: CGRect(x: 0, y: 0, width: l.frame.size.width, height: 0))
                bottomBorder?.lineWidth = 1
                bottomBorder?.stroke()
                
            }
        }
    }
    
    
}
