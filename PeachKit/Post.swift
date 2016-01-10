//
//  Post.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Foundation

public struct Post {
    
    /// Unique ID of the post
    public var id: String?
    
    /// ID of the stream the post belongs to
    public var streamID: String?
    
    /// Array of messages relating to the post
    public var message: [Message] = []
    
    /// How many comments are on the post
    public var commentCount: Int?
    
    /// How many likes are on the post
    public var likeCount: Int?
    
    /// Array of comments
    public var comments: [Comment] = []
    
    /// Was this post liked by the logged in user
    public var likedByMe: Bool = false
    
    /// Is the post unread
    public var isUnread: Bool = false
    
    /// When was this post created
    public var createdTime: Int64?
    
    /// When was this post updated
    public var updatedTime: Int64?
    
}
