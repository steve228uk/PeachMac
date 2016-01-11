//
//  PeachViewController.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachViewController: NSViewController {

    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.titlebarAppearsTransparent = false
        view.window?.movableByWindowBackground  = false
        
//        view.window?.titleVisibility = .Hidden
        
//        view.window?.titlebarAppearsTransparent = true
//        view.window?.movableByWindowBackground  = true
    }
    
}
