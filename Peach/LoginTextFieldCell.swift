//
//  LoginTextFieldCell.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class LoginTextFieldCell: NSTextFieldCell {

    override func drawingRectForBounds(theRect: NSRect) -> NSRect {
        return NSMakeRect(theRect.origin.x + 10, theRect.origin.y + 10, theRect.size.width - 20.0, theRect.size.height - 20.0)
    }
    
}
