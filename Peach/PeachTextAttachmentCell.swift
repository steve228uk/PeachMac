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
        
        if let view = controlView {
            let label = NSTextField(frame: cellFrame)
            label.stringValue = stringValue
            label.bordered = false
            label.drawsBackground = false
            label.cell?.drawWithFrame(cellFrame, inView: view)
        }
        
    }
    
    override func cellSize() -> NSSize {
        return attributedStringValue.size()
    }
    
}
