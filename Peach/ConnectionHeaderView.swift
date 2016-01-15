//
//  ConnectionHeaderView.swift
//  Peach
//
//  Created by Stephen Radford on 15/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

protocol ConnectionHeaderViewDelegate {
    
    func headerViewMouseDown(theEvent: NSEvent)
    
}

class ConnectionHeaderView: NSView {

    var stream: Stream? = nil {
        didSet {
            if let s = stream {
                nameLabel.stringValue = s.displayName!
            }
        }
    }
    
    var delegate: ConnectionHeaderViewDelegate?
    
    @IBOutlet weak var nameLabel: NSTextField!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        layer?.backgroundColor = NSColor.whiteColor().CGColor
        layer?.borderColor = NSColor.peachBorderColor().CGColor
        layer?.borderWidth = 2
        layer?.cornerRadius = 8
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
        delegate?.headerViewMouseDown(theEvent)
    }
    
}
