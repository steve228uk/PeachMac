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
        textContainerInset = NSMakeSize(10, 10)
    }
    
    /**
     Fetch the attachement fragments from the text view
     
     - returns: Array of fragments
     */
    func getFragments() -> [AnyObject] {
        let attString = attributedString()
        var fragments: [AnyObject] = []
        
        attString.enumerateAttribute(NSAttachmentAttributeName, inRange: NSMakeRange(0, attString.length), options: []) { object, range, pointer in
            
            if object == nil {
                // if there's no object then this is just text and we can safely extract it at the range
                fragments.append(attString.attributedSubstringFromRange(range).string.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet()))
            } else {
                
                if let attachment = object as? NSTextAttachment {
                    if let data = attachment.fileWrapper?.regularFileContents {
                        fragments.append(data)
                    }
                }
                
            }
            
        }
        
        return fragments
    }
    
}
