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

    var post: Post?
    
    @IBAction func likePost(sender: AnyObject) {
        post?.like()
    }
    
}
