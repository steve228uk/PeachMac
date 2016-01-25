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

    override var title: String? {
        didSet {
            if let t = title {
                titleView.stringValue = t
            }
        }
    }
    
    var borderVisible = true {
        didSet {
            if let v = view as? PeachToolbarView {
                v.showBorder = borderVisible
                v.needsDisplay = true
            }
        }
    }
    
    @IBOutlet weak var backButton: NSButton!
    
    @IBOutlet weak var titleView: NSTextField!
    
    var delegate: PeachNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(sender: AnyObject?) {
        delegate?.sendNavigationBack(sender)
    }
    
    
}
