//
//  MagicInputHandler.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

protocol MagicInputHandlerDelegate {

    func appendComplexAttachment(attachment: NSTextAttachment)
    
}

class MagicInputHandler: MagicInputDelegate {
    
    var textView: NSTextView
    
    var delegate: MagicInputHandlerDelegate?
    
    init(textView: NSTextView) {
        self.textView = textView
    }
    
    func handleAction(input: String) {    }
    
}
