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
    
    @IBOutlet weak var likeCount: NSTextField!

    var post: Post? {
        didSet {
            if let p = post {
                likeBtn.state =  (p.likedByMe) ? 1 : 0
                if let count = p.likeCount {
                    likeCount.stringValue = "\(count)"
                    likeCount.sizeToFit()
                }
            }
        }
    }
    
    @IBAction func likePost(sender: AnyObject) {
        if let p = post {
            p.like { error in
                if let count = self.post?.likeCount {
                    self.likeCount.stringValue = "\(count)"
                }
            }
        }
    }
    
}
