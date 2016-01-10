//
//  Connection.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public struct Stream {
    
    /// Unique ID of the stream
    public var id: String?
    
    /// Username belonging to the stream
    public var name: String?
    
    /// Display name belonging to the stream
    public var displayName: String?
    
    /// URL to the avatar
    public var avatarSrc: String?
    
    /// Is the profile public?
    public var isPublic: Bool = false
    
    /// Do you follow the profile?
    public var youFollow: Bool = false
    
    /// Do they follow you?
    public var followsYou: Bool = false
    
    /// Array of `Post`s
    public var posts: [Post] = []
    
}

extension Peach {
    
    typealias Connection = Stream
    
    /**
     Fetch streams from the Peach API
     
     - parameter callback: Callback returns array of streams and optional `NSError`
     */
    public class func getStreams(callback: ([Stream], NSError?) -> Void) {
        
        Alamofire.request(API.Connections)
            .responseJSON { response in
                print(response.result.value)
            }
        
    }
    
    /**
     Fetch connections from the Peach API. This is an alias of streams.
     
     - parameter callback: Callback returns array of streams and optional `NSError`
     */
    public class func getConnections(callback: ([Stream], NSError?) -> Void) {
        self.getStreams(callback)
    }
    
    /**
     Fetch a stream by its ID
     
     - parameter id:       The stream ID
     - parameter callback: Callback returns stream and optional NSError
     */
    public class func getStreamByID(id: String, callback: (Stream?, NSError?) -> Void) {
        
        Alamofire.request(API.Stream(id))
            .responseJSON { response in
                
                if response.result.isSuccess {
                    print(response.result.value)
                } else {
                    callback(nil, response.result.error)
                }
                
            }
        
    }
    
}