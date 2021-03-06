//
//  PostLinkItem.swift
//  Peach
//
//  Created by Stephen Radford on 22/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class PostLinkItem: NSCollectionViewItem {

    @IBOutlet weak var subView: NSView!
    
    var link: LinkMessage? {
        didSet {
            if let l = link {
                if let title = l.title {
                    titleLabel.stringValue = title
                } else {
                    titleLabel.stringValue = ""
                }
                
                if let desc = l.description {
                    descriptionLabel.stringValue = desc
                } else if let title = l.title {
                    descriptionLabel.stringValue = title
                } else {
                    descriptionLabel.stringValue = ""
                }
                
                imageView?.image = nil
                
                if let src = l.imageURL {
                    
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        let image = NSImage(byReferencingURL: NSURL(string: src)!).cropToSquare()
                        dispatch_async(dispatch_get_main_queue()) {
                            self.imageView?.image = image
                        }
                    }
                    
                }

            }
        }
    }
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var descriptionLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subView.wantsLayer = true
        subView.layer?.borderColor = NSColor.peachBorderColor().CGColor
        subView.layer?.borderWidth = 2
        subView.layer?.cornerRadius = 6
        
        imageView?.wantsLayer = true
        imageView?.layer?.backgroundColor = NSColor.lightGrayColor().CGColor
        imageView?.layer?.cornerRadius = 22
        imageView?.layer?.masksToBounds = true
    }
    
    override func mouseUp(theEvent: NSEvent) {
        if let url = link?.url {
            NSWorkspace.sharedWorkspace().openURL(NSURL(string: url)!)
        }
    }
    
}
