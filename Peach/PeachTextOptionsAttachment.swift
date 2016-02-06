//
//  PeachTextOptionsAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 03/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachTextOptionsAttachment: NSTextAttachment {

    var text: String?
    var textView: NSTextView?
    var options: [String]?
    
    init(options: [String], textView: NSTextView?) {
        super.init(data: nil, ofType: nil)
        
        self.options = options
        self.textView = textView
        
        if let options = self.options {
            let cell = PeachTextOptionsAttachmentCell(textCell: options[0], textView: textView)
            cell.options = options
            attachmentCell = cell
            text = options[0]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attachmentBoundsForTextContainer(textContainer: NSTextContainer?, proposedLineFragment lineFrag: NSRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> NSRect {
        return NSRect(x: 0, y: 0, width: 100, height: 20)
    }

    
}
