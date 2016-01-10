//
//  ConnectionsViewController.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ConnectionsViewController: PeachViewController {

    override func viewDidAppear() {
        super.viewDidAppear()
    
        Peach.getStreamByID(streamID!) { stream, error in
            
        }
        
    }
    
}
