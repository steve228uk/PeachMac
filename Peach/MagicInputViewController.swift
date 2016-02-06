//
//  MagicInputViewController.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

protocol MagicInputDelegate {
    
    func handleAction(input: String)
    
}

class MagicInputViewController: NSViewController {
    
    var delegate: MagicInputDelegate?

    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet weak var sendButton: NSButton!
    
    @IBAction func sendButtonClicked(sender: AnyObject) {
        delegate?.handleAction(textField.stringValue)
    }
    
}
