//
//  DeferredAttachmentHandler.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class DeferredAttachmentHandler: NSObject {
    
    var textView: NSTextView?
    
    var delegate: DeferredAttachmentDelegate?
    
    init(textView: NSTextView) {
        super.init()
        self.textView = textView
        handle()
    }
    
    func handle() { }
    
}
