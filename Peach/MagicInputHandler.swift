//
//  MagicInputHandler.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class MagicInputHandler: MagicInputDelegate {
    
    var textView: NSTextView
    
    weak var delegate: DeferredAttachmentDelegate?
    
    init(textView: NSTextView) {
        self.textView = textView
    }
    
    func handleAction(input: String) {    }
    
}
