//
//  ComposeViewController+MagicInputHandlerDelegate.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension ComposeViewController: MagicInputHandlerDelegate {
    
    func appendComplexAttachment(attachment: NSTextAttachment) {
        
        textView.textStorage?.setAttributedString(textView.attributedString().attributedStringByRemovingLastWord())
        textView.textStorage?.appendAttributedString(attachment.attributedString)
        textView.textStorage?.appendAttributedString(NSAttributedString(string: "\n\n"))
        
        magicInputController?.view.hidden = true
        
        view.window?.makeFirstResponder(textView)
        
    }
    
}
