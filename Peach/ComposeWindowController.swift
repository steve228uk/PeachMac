//
//  ComposeWindowController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ComposeWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        NSApplication.sharedApplication().menu?.itemWithTag(2)?.hidden = false
    }
    
    override func showWindow(sender: AnyObject?) {
        super.showWindow(sender)
        
    }
    
    @IBAction func save(sender: AnyObject?) {
        let vc = contentViewController as? ComposeViewController
        vc?.save()
    }
    
}
