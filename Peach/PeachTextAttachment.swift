//
//  PeachTextAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 31/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachTextAttachment: NSTextAttachment {

    var text: String?
    
    init(string: String) {
        super.init(data: nil, ofType: nil)
        self.attachmentCell = PeachTextAttachmentCell(textCell: string)
        text = string
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attachmentBoundsForTextContainer(textContainer: NSTextContainer?, proposedLineFragment lineFrag: NSRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> NSRect {
        return NSRect(x: 0, y: 0, width: 100, height: 20)
    }
    
}
