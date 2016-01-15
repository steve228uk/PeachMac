//
//  ProfileBannerView.swift
//  Peach
//
//  Created by Stephen Radford on 15/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ProfileBannerView: NSView {

    @IBOutlet weak var avatar: NSImageView!
    
    @IBOutlet weak var nameLabel: NSTextField!
    
    @IBOutlet weak var postLabel: NSTextField!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        avatar.layer?.backgroundColor = NSColor.peachBorderColor().CGColor
        avatar.layer?.cornerRadius = 22
        avatar.layer?.masksToBounds = true
        
        layer?.backgroundColor = NSColor.whiteColor().CGColor
        layer?.borderColor = NSColor.peachBorderColor().CGColor
        layer?.borderWidth = 2
        layer?.cornerRadius = 10
    }
    
    override func mouseUp(theEvent: NSEvent) {
        if let header = superview as? ConnectionHeaderView {
            header.delegate?.profileMouseUp(theEvent)
        }
        layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    override func mouseDown(theEvent: NSEvent) {
        layer?.backgroundColor = NSColor.peachBorderColor().CGColor
    }
    
}
