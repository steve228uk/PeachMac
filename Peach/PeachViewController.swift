//
//  PeachViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachViewController: NSViewController {
    
    var tabController: PeachTabViewController? {
        get {
            return parentViewController as? PeachTabViewController
        }
    }
    
    var container: PeachContainerViewController? {
        get {
            return NSApplication.sharedApplication().windows[0].contentViewController as? PeachContainerViewController
        }
    }
    
}
