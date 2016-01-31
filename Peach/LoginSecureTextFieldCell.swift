//
//  LoginSecureTextFieldCell.swift
//  Peach
//
//  Created by Stephen Radford on 31/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class LoginSecureTextFieldCell: NSSecureTextFieldCell {

    override func drawWithFrame(cellFrame: NSRect, inView controlView: NSView) {
        let rect = NSMakeRect(cellFrame.origin.x + 10, cellFrame.origin.y + 7, cellFrame.size.width - 20, cellFrame.size.height - 14)
        super.drawWithFrame(rect, inView: controlView)
        
        bordered = false
        editable = true
        enabled = true
        drawsBackground = true
        focusRingType = .None
        font = NSFont.systemFontOfSize(18)
        backgroundColor = NSColor(calibratedHue:0, saturation:0, brightness:0.96, alpha:1)
    }
    
    override func selectWithFrame(aRect: NSRect, inView controlView: NSView, editor textObj: NSText, delegate anObject: AnyObject?, start selStart: Int, length selLength: Int) {
        let rect = NSMakeRect(aRect.origin.x + 10, aRect.origin.y + 7, aRect.size.width - 20, aRect.size.height - 14)
        super.selectWithFrame(rect, inView: controlView, editor: textObj, delegate: anObject, start: selStart, length: selLength)
    }
    
}
