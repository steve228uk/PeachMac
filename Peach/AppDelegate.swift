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
import GiphyKit
import ImgurKit

let keychain = Keychain(service: "uk.co.wearecocoon.Peach")
var token: String?
var streamID: String?

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        Giphy.APIKey = "dc6zaTOxFJmzC"
        Imgur.clientID = "f69ce8fb3b0ac47"
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        NSApplication.sharedApplication().windows[0].makeKeyAndOrderFront(self)
        return true
    }

}

