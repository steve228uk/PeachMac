//
//  Message.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Foundation

public struct Message {
    
    /// What type of message is this?
    public var type: MessageType?
    
    /// Text releated to the message
    public var text: String?
    
    /// Source URL of any image
    public var src: String?
    
    /// Width of any image
    public var width: Int?
    
    /// Height of any image
    public var height: Int?
    
}

public enum MessageType {
    
    case Text
    case GIF
    case Image
    case Shout
    case Video
    case Drawing
    
}