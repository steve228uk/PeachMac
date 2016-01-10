//
//  API.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Alamofire

enum API: URLRequestConvertible {
    
    // MARK: - Cases
    
    case Authenticate(String, String)
    case Activity
    case Connections
    case Stream(String)
    
    // MARK: - URLRequestConvertible
    
    static let base = "https://v1.peachapi.com"
    
    var method: Alamofire.Method {
        switch self {
            case .Authenticate:
                return .POST
            default:
                return .GET
        }
    }
    
    var path: String {
        switch self {
            case .Authenticate:
                return "/login"
            case .Activity:
                return "/stream/activity"
            case .Connections:
                return "/connections"
            case .Stream(let id):
                return "/stream/id/\(id)"
        }
    }
    
    var URLRequest: NSMutableURLRequest {
    
        let URL = NSURL(string: API.base)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = Peach.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
            case .Authenticate(let email, let password):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: ["email": email, "password": password]).0
            default:
                return mutableURLRequest
        }
        
    }
    
}