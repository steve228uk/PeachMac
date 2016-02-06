//
//  LoginTextField.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class LoginTextField: NSTextField {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        sharedInit()
    }
    
    func sharedInit() {
        wantsLayer = true
        layer?.backgroundColor = NSColor(calibratedHue:0, saturation:0, brightness:0.96, alpha:1).CGColor
        layer?.cornerRadius = 5
        layer?.masksToBounds = true
        
        let cell = LoginTextFieldCell(textCell: "")
        cell.placeholderString = "Username or Email Address"
        self.cell = cell
    }
    
}
