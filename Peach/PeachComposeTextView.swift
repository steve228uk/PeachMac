//
//  PeachComposeTextView.swift
//  Peach
//
//  Created by Stephen Radford on 23/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachComposeTextView: NSTextView {
    
    override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
        super.init(frame: frameRect, textContainer: container)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    func sharedInit() {
        importsGraphics = true
    }
    
    func getImages() -> [NSData] {
        let attString = attributedString()
        var images: [NSData] = []
        
        attString.enumerateAttribute(NSAttachmentAttributeName, inRange: NSMakeRange(0,attString.length), options: []) { (object, Range, pointer_t) -> Void in
            
            if let attachment = object as? NSTextAttachment {
                if let data = attachment.fileWrapper?.regularFileContents {
                    images.append(data)
                }
            }
            
        }
        
        return images
    }
    
}
