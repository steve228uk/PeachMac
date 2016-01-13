//
//  ConnectionsViewController.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ConnectionsViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    
    /// The streams that were fetched from Peach
    var streams: [Stream] = []
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        Peach.getStreams { streams, error in
            self.streams = streams
            self.tableView.reloadData()
        }

    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.toolbar?.removeItemAtIndex(0)
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return streams.count
    }
    
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let v = tableView.makeViewWithIdentifier("connectionCell", owner: self) as! ConnectionsTableCellView
        let stream = streams[row]
        
        if let name = stream.displayName {
            v.name.stringValue = name
        }
        
        if stream.posts.count > 0 {
            let post = stream.posts[0]
            
            switch post.message[0].type! {
                case .Image:
                    v.post.stringValue = "Image"
                case .GIF:
                    v.post.stringValue = "GIF"
                case .Video:
                    v.post.stringValue = "Video"
                default:
                    if let text = post.message[0].text {
                        v.post.stringValue = text
                    }
                    break
            }
            
        }
        
        stream.getAvatar { image in
            v.avatar.image = image
        }
        
        return v
    }
    
    
    // Called when a table row is clicked
    // TODO: Implement a slide forward and slide back seque a la iOS.
    func tableViewSelectionDidChange(notification: NSNotification) {
        
        if let tc = parentViewController as? PeachTabViewController {
            if let vc = tc.childViewControllers[1] as? StreamViewController {
                let stream = streams[tableView.selectedRow]
                vc.streamID = stream.id
                tc.selectedTabViewItemIndex = 1
            }
        }
        
    }
    
}
