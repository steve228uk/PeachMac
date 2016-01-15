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
            
            if let s = stream {
                
                profileBanner.nameLabel.stringValue = s.displayName!
                
                s.getAvatar { image in
                    self.profileBanner.avatar.image = image
                }
                
                if s.posts.count > 0 {
                    let post = s.posts[0]
                    if post.message.count > 0 {
                        switch post.message[0].type! {
                            case .Text:
                                if let text = post.message[0].text {
                                    profileBanner.postLabel.stringValue = text
                                } else {
                                    profileBanner.postLabel.stringValue = post.message[0].type!.stringValue
                                }
                            default:
                                profileBanner.postLabel.stringValue = post.message[0].type!.stringValue
                        }
                    }
                }
                
            }
            
        }
    }
    
    var delegate: ConnectionHeaderViewDelegate?
    
    @IBOutlet weak var profileBanner: ProfileBannerView!
    
}
