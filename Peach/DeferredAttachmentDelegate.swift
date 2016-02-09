//
//  DeferredAttachmentDelegate.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

protocol DeferredAttachmentDelegate: NSObjectProtocol {
    
    func appendDeferredAttachment(attachment: NSTextAttachment)
    
}