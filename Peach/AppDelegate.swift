//
//  AppDelegate.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import KeychainAccess
import PeachKit

let keychain = Keychain(service: "uk.co.wearecocoon.Peach")
var token: String?
var streamID: String?

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE0NTI0NjU1NDMsInN0cmVhbUlEIjoiOGU0MGI5ZGE0OWYzNDFmNDhiYWJiYmU0OGFkZGY2NzAifQ.VWycg6N-MtptafKdBB_pz99ZNraEiGVmGm1ShzXJqao"
        streamID = "8e40b9da49f341f48babbbe48addf670"
        
        if token != nil {
            
            Peach.OAuthToken = token
            Peach.streamID = streamID
            
            let sb = NSStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateControllerWithIdentifier("connections") as? ConnectionsViewController
            
            NSApplication.sharedApplication().windows[0].contentViewController = vc
            
        }
        
    }

}

