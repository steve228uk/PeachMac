//
//  PostActionsView.swift
//  Peach
//
//  Created by Stephen Radford on 28/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PostActionsView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        NSColor(calibratedHue:0, saturation:0, brightness:0.90, alpha:1).setStroke()
        let bottomBorder = NSBezierPath(rect: CGRect(x: 18, y: 0, width: 20, height: 0))
        bottomBorder.lineWidth = 1
        bottomBorder.stroke()
    }
    
}
