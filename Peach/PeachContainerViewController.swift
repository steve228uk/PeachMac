//
//  PeachContainerViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class PeachContainerViewController: NSViewController {
    
    @IBOutlet weak var container: NSView!
    
    var toolbar: PeachToolbarViewController?
    
    // MARK: - Tab Bar Icons
    
    @IBOutlet weak var avatar: NSImageView!
    
    @IBOutlet weak var friendsBtn: NSButton!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        
        avatar.wantsLayer = true
        avatar.layer?.backgroundColor = NSColor.whiteColor().CGColor
        avatar.layer?.cornerRadius = 23
        avatar.layer?.masksToBounds = true
        
        if let id = Peach.streamID {
            Peach.getStreamByID(id) { stream, error in
                stream?.getAvatar { image in
                    self.avatar.image = image.cropToSquare()
                }
            }
        }
        
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationController as? PeachToolbarViewController {
            toolbar = vc
        }
    }
    
}
