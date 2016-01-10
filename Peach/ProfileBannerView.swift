//
//  ProfileBannerView.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ProfileBannerView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        layer?.backgroundColor = NSColor.whiteColor().CGColor
        layer?.borderColor = NSColor(hue:0.07, saturation:0.08, brightness:0.94, alpha:1).CGColor
        layer?.borderWidth = 2
        layer?.cornerRadius = 5
    }
    
}
