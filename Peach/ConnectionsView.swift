//
//  ConnectionsView.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ConnectionsView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        layer?.backgroundColor = NSColor(hue:0.07, saturation:0.09, brightness:0.99, alpha:1).CGColor
    }
    
}
