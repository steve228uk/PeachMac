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
        
        window?.titlebarAppearsTransparent = true
        window?.movableByWindowBackground  = true
        window?.titleVisibility = .Hidden
        
        NSApplication.sharedApplication().menu?.itemWithTag(2)?.hidden = false
    }
    
    deinit {
        contentViewController?.view.removeFromSuperview()
        contentViewController?.removeFromParentViewController()
    }
    
}
