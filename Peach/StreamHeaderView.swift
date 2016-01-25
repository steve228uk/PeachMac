//
//  SteamHeaderView.swift
//  Peach
//
//  Created by Stephen Radford on 15/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class StreamHeaderView: NSView {

    @IBOutlet var nameLabel: NSTextField!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        if let l = layer {
        
            l.zPosition = 10
            
            l.backgroundColor = NSColor.whiteColor().CGColor
            l.masksToBounds = false
            
            let shadow = NSShadow()
            shadow.shadowColor = NSColor(calibratedHue: 0, saturation: 0, brightness: 0, alpha: 0.2)
            shadow.shadowOffset = CGSize(width: 0, height: 1)
            shadow.shadowBlurRadius = 3
            
            self.shadow = shadow
            
            NSColor(calibratedHue:0, saturation:0, brightness:0.79, alpha:1).setStroke()
            
            let bottomBorder = NSBezierPath(rect: CGRect(x: 0, y: 0, width: l.frame.size.width, height: 0))
            bottomBorder.lineWidth = 1
            bottomBorder.stroke()
            
        }
        
    }
    
}
