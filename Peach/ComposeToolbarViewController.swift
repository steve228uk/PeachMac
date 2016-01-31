//
//  ComposeToolbarViewController.swift
//  Peach
//
//  Created by Stephen Radford on 31/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ComposeToolbarViewController: NSViewController {

    @IBOutlet weak var indicator: NSProgressIndicator!
    
    @IBOutlet weak var saveBtn: NSButton!
    
    override func viewDidLayout() {
        super.viewDidLayout()
    }
    
    @IBAction func save(sender: AnyObject) {
        if let vc = parentViewController as? ComposeViewController {
            
            saveBtn.hidden = true
            indicator.hidden = false
            indicator.startAnimation(sender)
            
            vc.save { error in
                
                if error != nil {
                    self.saveBtn.hidden = false
                    self.indicator.stopAnimation(sender)
                    self.indicator.hidden = true
                }
                
            }
            
        }
    }
    
}
