//
//  AvatarView.swift
//  Peach
//
//  Created by Stephen Radford on 27/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class AvatarView: FadingImageView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        layer?.backgroundColor = NSColor.whiteColor().CGColor
        layer?.cornerRadius = 23
        layer?.masksToBounds = true
    }
    
}
