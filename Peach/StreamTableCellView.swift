//
//  StreamTableCellView.swift
//  Peach
//
//  Created by Stephen Radford on 13/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class StreamTableCellView: NSTableCellView {

    @IBOutlet weak var label: NSTextField!
    
    var post: Post? {
        didSet {
            renderMessages()
        }
    }
    
    func renderMessages() {
        if let p = post {
            for message in p.message {
                if message.type == .Text && message.text != nil {
                    label.stringValue = message.text!
                }
            }
        }
    }
    
}
