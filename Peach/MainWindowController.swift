//
//  MainWindowController.swift
//  Peach
//
//  Created by Stephen Radford on 25/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.titleVisibility = .Hidden
        window?.titlebarAppearsTransparent = true
        window?.movableByWindowBackground  = true
        window?.toolbar?.visible = false
    }
    
    
    
}
