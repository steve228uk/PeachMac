//
//  ConnectionHeaderView.swift
//  Peach
//
//  Created by Stephen Radford on 15/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

protocol ConnectionHeaderViewDelegate {
    func profileMouseUp(theEvent: NSEvent)
}

class ConnectionHeaderView: NSView {

    var stream: Stream? = nil {
        didSet {
            
            self.profileBanner.avatar.image = nil
            
            if let s = stream {
                
                profileBanner.nameLabel.stringValue = s.displayName!
                
                if s.avatarSrc != nil {
                    s.getAvatar { image in
                        self.profileBanner.avatar.image = image
                    }
                } else {
                    self.profileBanner.avatar.image = NSImage(named: "placeholder")
                }
                
                // TODO: Refactor this. It's a fucking mess.
                
                if s.posts.count > 0 {
                    let post = s.posts[0]
                    if post.message.count > 0 {
                        switch post.message[0].type {
                            case .Text:
                                let textMessage = post.message[0] as! TextMessage
                                if let text = textMessage.text {
                                    profileBanner.postLabel.stringValue = text
                                } else {
                                    profileBanner.postLabel.stringValue = post.message[0].type.stringValue
                                }
                            case .Location:
                                let locationMessage = post.message[0] as! LocationMessage
                                if let name = locationMessage.name {
                                    profileBanner.postLabel.stringValue = name
                                } else {
                                    profileBanner.postLabel.stringValue = post.message[0].type.stringValue
                                }
                            case .Music:
                                let musicMessage = post.message[0] as! MusicMessage
                                if let name = musicMessage.title {
                                    profileBanner.postLabel.stringValue = name
                                } else {
                                    profileBanner.postLabel.stringValue = post.message[0].type.stringValue
                                }
                            default:
                                profileBanner.postLabel.stringValue = post.message[0].type.stringValue
                        }
                    } else {
                        profileBanner.postLabel.stringValue = ""
                    }
                } else {
                    profileBanner.postLabel.stringValue = ""
                }
                
            }
            
        }
    }
    
    var delegate: ConnectionHeaderViewDelegate?
    
    @IBOutlet weak var profileBanner: ProfileBannerView!
    
}
