//
//  ComposeViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ComposeViewController: PeachViewController {
    
    @IBOutlet var textView: NSTextView!
    
    func save() {
        
        let msg = TextMessage()
        msg.text = textView.string
        
        Peach.createPost([msg]) { error in
        }
        
        view.window?.close()
        
    }
    
}
