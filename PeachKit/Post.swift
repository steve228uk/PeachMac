//
//  Post.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Post {
    
    /// Unique ID of the post
    public var id: String?
    
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

extension Peach {
    
    internal class func parsePost(json: JSON) -> Post {
        var post = Post()
        
        post.id = json["id"].string
        post.commentCount = json["commentCount"].int
        post.updatedTime = json["updatedTime"].int64
        post.createdTime = json["createdTime"].int64
        post.likeCount = json["likeCount"].int
        
        if let isUnread = json["isUnread"].bool {
            post.isUnread = isUnread
        }
        
        if let msg = json["message"].array {
            post.message = msg.map(parseMessage)
        }
        
        return post
    }
    
}
