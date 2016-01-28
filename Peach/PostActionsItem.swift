//
//  PostActionsItem.swift
//  Peach
//
//  Created by Stephen Radford on 16/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class PostActionsItem: NSCollectionViewItem {
    
    @IBOutlet weak var likeBtn: NSButton!

    var post: Post? {
        didSet {
            if let p = post {
                if p.likedByMe {
                    likeBtn.state = 1
                }
            }
        }
    }
    
    @IBAction func likePost(sender: AnyObject) {
        post?.like()
    }
    
}
