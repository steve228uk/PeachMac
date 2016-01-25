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
        view.window?.titlebarAppearsTransparent = true
        view.window?.movableByWindowBackground  = true
        view.window?.toolbar?.visible = false
    }
    
    var tabController: PeachTabViewController? {
        get {
            return parentViewController as? PeachTabViewController
        }
    }
    
    var container: PeachContainerViewController? {
        get {
            return tabController?.parentViewController as? PeachContainerViewController
        }
    }
    
}
