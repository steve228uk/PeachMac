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
    
    @IBOutlet weak var headerView: StreamHeaderView!
    
    var streamID: String?
    
    var stream: Stream?
    
    var posts: [Post] = []
    
    var tabController: PeachTabViewController? {
        get {
           return parentViewController as? PeachTabViewController
        }
    }
    
    override func viewDidLoad() {
        tableView.layer?.zPosition = 9
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Wipe the current state
        stream = nil
        posts = []
        tableView.reloadData()
        headerView.nameLabel.stringValue = ""
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.toolbar?.insertItemWithItemIdentifier("back", atIndex: 0)
        if let window = view.window?.windowController as? PeachMainWindowController {
            window.delegate = self
        }
        
        if let id = streamID {
            Peach.getStreamByID(id) { stream, error in
                if let s = stream {
                    self.stream = s
                    if let name = s.displayName {
                        Swift.print(name)
                        self.headerView.nameLabel.stringValue = name
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    func sendNavigationBack(sender: AnyObject?) {
        tabController?.selectedTabViewItemIndex = 0
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        if let s = stream {
            return s.posts.count
        }
        return 0
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let v = tableView.makeViewWithIdentifier("streamCell", owner: self) as! StreamTableCellView
        v.post = stream!.posts[row]
        return v
    }
    
}
