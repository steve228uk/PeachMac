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
        
        Peach.getStreams { streams, error in
            self.streams = streams
            Swift.print(streams)
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return streams.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        if let name = streams[row].displayName {
            return name
        }
        return ""
    }
    
}
