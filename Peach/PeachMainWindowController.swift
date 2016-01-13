//
//  PeachMainWindowController.swift
//  Peach
//
//  Created by Stephen Radford on 13/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

protocol PeachMainWindowControllerDelegate {
    func sendNavigationBack(sender: AnyObject?)
}

class PeachMainWindowController: NSWindowController {

    var delegate: PeachMainWindowControllerDelegate?
    
    @IBAction func back(sender: AnyObject?) {
        delegate?.sendNavigationBack(sender)
    }

}
