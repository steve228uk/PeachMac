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
        
        token = keychain["token"]
        streamID = keychain["streamID"]
        
        if token != nil {
            
            Peach.OAuthToken = token
            Peach.streamID = streamID
            
            let sb = NSStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateControllerWithIdentifier("main") as? PeachContainerViewController
            
            NSApplication.sharedApplication().windows[0].contentViewController = vc
            
        }
        
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        NSApplication.sharedApplication().windows[0].makeKeyAndOrderFront(self)
        return true
    }

}

