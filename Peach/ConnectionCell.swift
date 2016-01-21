//
//  ConnectionCell.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ConnectionCell: NSView {

    var bottomBorder: NSBezierPath?
    var leftBorder: NSBezierPath?
    var rightBorder: NSBezierPath?
    var topBorder: NSBezierPath?
    
    /// Is it the first one in the list? If so, get maskin'
    var isFirst = false {
        didSet {
            if isFirst {

                
            } else {
                
            }
        }
    }
    
    /// Is it the last one in the list? If so, get maskin'
    var isLast = false {
        didSet {
            Swift.print(isLast)
        }
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        if let l = layer {

            NSColor.peachBorderColor().setStroke()
            
            bottomBorder = NSBezierPath(rect: CGRect(x: 0, y: 0, width: l.frame.size.width, height: 0))
            bottomBorder?.lineWidth = 1
            bottomBorder?.stroke()
            
            leftBorder = NSBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: l.frame.size.height))
            leftBorder?.lineWidth = 3
            leftBorder?.stroke()
            
            rightBorder = NSBezierPath(rect: CGRect(x: l.frame.size.width, y: 0, width: 0, height: l.frame.size.height))
            rightBorder?.lineWidth = 3
            rightBorder?.stroke()
            
            l.backgroundColor = NSColor.whiteColor().CGColor
            
            let cornerRadius: CGFloat = 10
            let path = NSBezierPath()
            path.moveToPoint(NSMakePoint(NSMinX(bounds), NSMinY(bounds)))
            
            let trc = NSMakePoint(NSMaxX(bounds), NSMinY(bounds))
            path.lineToPoint(NSMakePoint(NSMaxX(bounds) - cornerRadius, NSMinY(bounds)))
            path.curveToPoint(NSMakePoint(NSMaxX(bounds), NSMinY(bounds) + cornerRadius), controlPoint1: trc, controlPoint2: trc)
            
            path.lineToPoint(NSMakePoint(NSMaxX(bounds), NSMaxY(bounds)))
            path.lineToPoint(NSMakePoint(NSMinX(bounds), NSMaxY(bounds)))
            path.lineToPoint(NSMakePoint(NSMinX(bounds), NSMinY(bounds)))
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = path.toCGPath()
            
            l.mask = maskLayer
            
            
        }
        
    }
    
}
