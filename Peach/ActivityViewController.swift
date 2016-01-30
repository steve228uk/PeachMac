//
//  ActivityViewController.swift
//  Peach
//
//  Created by Stephen Radford on 30/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ActivityViewController: PeachViewController {

    override func viewDidAppear() {
        super.viewDidAppear()
        container?.toolbar?.title = "Activity"
    }
    
}
