//
//  StreamViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class StreamViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, PeachMainWindowControllerDelegate {

    @IBOutlet weak var tableView: NSTableView!
    
    var streamID: String?
    
    var posts: [Post] = []
    
    var tabController: PeachTabViewController? {
        get {
           return parentViewController as? PeachTabViewController
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        if let window = NSApplication.sharedApplication().windows[0].windowController as? PeachMainWindowController {
            window.delegate = self
        }
    }
    
    func sendNavigationBack(sender: AnyObject?) {
        tabController?.selectedTabViewItemIndex = 0
    }
    
}
