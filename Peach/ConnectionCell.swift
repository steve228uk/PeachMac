//
//  ConnectionCell.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ConnectionCell: NSView {

    var bottomBorder = CALayer()
    var leftBorder = CALayer()
    var rightBorder = CALayer()
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        if let l = layer {
            
            l.backgroundColor = NSColor.whiteColor().CGColor
            
            bottomBorder.frame = CGRect(x: 0, y: 0, width: l.frame.size.width, height: 1)
            bottomBorder.backgroundColor = NSColor.peachBorderColor().CGColor
            
            leftBorder.frame = CGRect(x: 0, y: 0, width: 2, height: l.frame.size.height)
            leftBorder.backgroundColor = NSColor.peachBorderColor().CGColor
            
            rightBorder.frame = CGRect(x: l.frame.size.width-2, y: 0, width: 2, height: l.frame.size.height)
            rightBorder.backgroundColor = NSColor.peachBorderColor().CGColor
            
            l.sublayers?.appendContentsOf([
                bottomBorder,
                leftBorder,
                rightBorder
            ])
            
        }
        
    }
    
}
