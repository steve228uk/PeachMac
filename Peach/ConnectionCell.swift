//
//  ConnectionCell.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ConnectionCell: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
}
