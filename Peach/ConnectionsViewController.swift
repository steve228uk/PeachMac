//
//  ConnectionsViewController.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ConnectionsViewController: PeachViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    
    /// The streams that were fetched from Peach
    var streams: [Stream] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.sizeLastColumnToFit()
        
        Peach.getStreams { streams, error in
            self.streams = streams
            self.tableView.reloadData()
        }
        
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
    
}
