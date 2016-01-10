//
//  PeachTabViewController.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachTabViewController: NSTabViewController {

    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.titlebarAppearsTransparent = true
        view.window?.movableByWindowBackground  = true
    }
    
}
