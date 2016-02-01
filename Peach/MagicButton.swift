//
//  MagicButton.swift
//  Peach
//
//  Created by Stephen Radford on 31/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class MagicButton: NSButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wantsLayer = true
        bordered = false
        
        layer?.masksToBounds = true
        layer?.backgroundColor = NSColor(hue:0, saturation:0, brightness:0.93, alpha:1).CGColor
        layer?.cornerRadius = 5
        layer?.borderWidth = 2
        layer?.borderColor = NSColor(hue:0, saturation:0, brightness:0.85, alpha:1).CGColor
        
        let attributes = [
            NSFontAttributeName: NSFont.systemFontOfSize(13, weight: NSFontWeightMedium),
            NSForegroundColorAttributeName: NSColor(hue:0, saturation:0, brightness:0.45, alpha:1)
        ]
        
        attributedTitle = NSAttributedString(string: title, attributes: attributes)
    }
    
}
