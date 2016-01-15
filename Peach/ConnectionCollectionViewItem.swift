//
//  ConnectionCollectionViewItem.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ConnectionCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var image: NSImageView!
    
    @IBOutlet weak var nameLabel: NSTextField!
    
    @IBOutlet weak var postLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.wantsLayer = true
        image.layer?.backgroundColor = NSColor.peachBorderColor().CGColor
        image.image = nil
        image.layer?.cornerRadius = 22
        image.layer?.masksToBounds = true
    }
    
    var stream: Stream? {
        didSet {
            
            image.image = nil
            
            if let s = stream {
                
                nameLabel.stringValue = stream!.displayName!
                
                if stream?.avatarSrc != nil {
                    stream?.getAvatar { image in
                        self.image.image = image
                    }
                } else {
                    image.image = NSImage(named: "placeholder")
                }
                
                if s.posts.count > 0 {
                    let post = s.posts[0]
                    if post.message.count > 0 {
                        switch post.message[0].type! {
                        case .Text:
                            if let text = post.message[0].text {
                                postLabel.stringValue = text
                            } else {
                                postLabel.stringValue = post.message[0].type!.stringValue
                            }
                        default:
                            postLabel.stringValue = post.message[0].type!.stringValue
                        }
                    } else {
                        postLabel.stringValue = ""
                    }
                } else {
                    postLabel.stringValue = ""
                }
                
            }
            
            
        }
    }

}
