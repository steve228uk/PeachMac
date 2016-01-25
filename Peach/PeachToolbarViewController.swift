//
//  PeachToolbarViewController.swift
//  Peach
//
//  Created by Stephen Radford on 24/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

protocol PeachNavigationDelegate {
    func sendNavigationBack(sender: AnyObject?)
}

class PeachToolbarViewController: NSViewController {

    @IBOutlet weak var backButton: NSButton!
    
    var delegate: PeachNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(sender: AnyObject?) {
        delegate?.sendNavigationBack(sender)
    }
    
}
