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
                
                if let avatarSrc = stream?.avatarSrc {
                    
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        let image = NSImage(byReferencingURL: NSURL(string: avatarSrc)!).cropToSquare()
                        dispatch_async(dispatch_get_main_queue()) {
                            self.image.image = image
                        }
                    }
                    
                } else {
                    image.image = NSImage(named: "placeholder")
                }
                
                if s.posts.count > 0 {
                    let post = s.posts[0]
                    if post.message.count > 0 {
                        switch post.message[0].type {
                        case .Text:
                            let textMessage = post.message[0] as! TextMessage
                            if let text = textMessage.text {
                                postLabel.stringValue = text
                            } else {
                                postLabel.stringValue = post.message[0].type.stringValue
                            }
                        case .Location:
                            let locationMessage = post.message[0] as! LocationMessage
                            if let name = locationMessage.name {
                                postLabel.stringValue = name
                            } else {
                                postLabel.stringValue = post.message[0].type.stringValue
                            }
                        case .Music:
                            let musicMessage = post.message[0] as! MusicMessage
                            if let name = musicMessage.title {
                                postLabel.stringValue = name
                            } else {
                                postLabel.stringValue = post.message[0].type.stringValue
                            }
                        default:
                            postLabel.stringValue = post.message[0].type.stringValue
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
