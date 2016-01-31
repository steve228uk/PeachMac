//
//  LoginButtonCell.swift
//  Peach
//
//  Created by Stephen Radford on 31/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class LoginButtonCell: NSButtonCell {

    override func highlight(flag: Bool, withFrame cellFrame: NSRect, inView controlView: NSView) {
        if flag {
            controlView.layer?.backgroundColor = NSColor(hue:0.96, saturation:0.68, brightness:0.85, alpha:1).CGColor
        } else {
            controlView.layer?.backgroundColor = NSColor(hue:0.96, saturation:0.68, brightness:0.93, alpha:1).CGColor
        }
    }
    
}
