//
//  GIFAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 08/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import GiphyKit

protocol GIFAttachmentCellDelegate: class {
    
    var imageData: NSData? { get set }
    
    var animationLayer: CALayer? { get set }
    
}

class GIFAttachment: NSTextAttachment, GIFAttachmentCellDelegate {

    var textView: NSTextView?
    
    var imageData: NSData?
    
    var animationLayer: CALayer?
    
    init(gifs: [GIF], textView: NSTextView) {
        super.init(data: nil, ofType: nil)
        self.textView = textView
        if gifs.count > 0 {
            let cell = GIFAttachmentCell(gifs: gifs, textView: textView)
            cell.delegate = self
            
            attachmentCell = cell
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attachmentBoundsForTextContainer(textContainer: NSTextContainer?, proposedLineFragment lineFrag: NSRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> NSRect {
        return NSRect(x: 0, y: 0, width: 100, height: 20)
    }
    
}
