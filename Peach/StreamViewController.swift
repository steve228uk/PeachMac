//
//  StreamViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class StreamViewController: NSViewController, PeachMainWindowControllerDelegate {
    
    var streamID: String?
    
    var stream: Stream?
    
    var posts: [Post] = []
    
    var tabController: PeachTabViewController? {
        get {
           return parentViewController as? PeachTabViewController
        }
    }
    
    @IBOutlet weak var headerView: StreamHeaderView!
    
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.toolbar?.insertItemWithItemIdentifier("back", atIndex: 0)
        if let window = view.window?.windowController as? PeachMainWindowController {
            window.delegate = self
        }
        
        loadStream()
        
    }
    
    func loadStream() {
        if let id = streamID {
            Peach.getStreamByID(id) { stream, error in
                if let s = stream {
                    self.stream = s
                    if let name = s.displayName {
                        Swift.print(name)
                        self.headerView.nameLabel.stringValue = name
                    }
                }
            }
        }
    }
    
    func sendNavigationBack(sender: AnyObject?) {
        tabController?.selectedTabViewItemIndex = 0
    }
    
    
}
