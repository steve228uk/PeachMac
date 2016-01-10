//
//  LoginButton.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class LoginButton: NSButton {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        wantsLayer = true
        bordered = false
        
        frame = NSRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 42)
        
        layer?.backgroundColor = NSColor(hue:0.96, saturation:0.68, brightness:0.93, alpha:1).CGColor
        layer?.cornerRadius = 5
    }
    
    override func awakeFromNib() {
        
        let para = NSMutableParagraphStyle()
        para.alignment = .Center
        
        attributedTitle = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: NSColor.whiteColor(), NSFontAttributeName: NSFont.systemFontOfSize(18), NSParagraphStyleAttributeName: para])
    
        
    }
    
}
