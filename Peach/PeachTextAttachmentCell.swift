//
//  PeachTextAttachmentCell.swift
//  Peach
//
//  Created by Stephen Radford on 31/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachTextAttachmentCell: NSTextAttachmentCell {

    override func drawWithFrame(cellFrame: NSRect, inView controlView: NSView?) {
        
        NSColor.init(hue: 0, saturation: 0, brightness: 0.9, alpha: 1).setStroke()
        let insetRect = NSInsetRect(cellFrame, 1, 1)
        let path = NSBezierPath(roundedRect: insetRect, xRadius: 5, yRadius: 5)
        path.lineWidth = 2
        path.stroke()
        
        if let view = controlView {
            let label = NSTextField(frame: cellFrame)
            label.attributedStringValue = attributedStringValue
            label.bordered = false
            label.drawsBackground = false
            let insetRect = NSInsetRect(cellFrame, 5, 5)
            label.cell?.drawWithFrame(insetRect, inView: view)
        }
        
    }
    
    override func cellSize() -> NSSize {
        
        var textSize = attributedStringValue.size()
        textSize.width += 15
        textSize.height += 10
        
        return textSize
    }
    
}
