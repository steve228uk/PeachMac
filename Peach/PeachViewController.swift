//
//  PeachViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachViewController: NSViewController {
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.titleVisibility = .Hidden
        view.window?.titlebarAppearsTransparent = false
        view.window?.movableByWindowBackground  = false
        view.window?.toolbar?.visible = true
    }
    
}
