//
//  ComposeWindowController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ComposeWindowController: NSWindowController {
    
    @IBAction func save(sender: AnyObject?) {
        let vc = contentViewController as? ComposeViewController
        vc?.save()
    }
    
}
