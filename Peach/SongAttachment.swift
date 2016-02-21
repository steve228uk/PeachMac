//
//  SongAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import ScriptingBridge

class SongAttachment: PeachTextAttachment {

    var track: String?
    
    init(textView: NSTextView?) {
        
        var string: String? = nil
        
        // Check if Spotify or iTunes is open
        
        var iTunesOpen = false
        var spotifyOpen = false
        
        let apps = NSWorkspace.sharedWorkspace().runningApplications
        for app in apps {
            if let bundleID = app.bundleIdentifier {
                if bundleID == "com.apple.iTunes" {
                    iTunesOpen = true
                } else if bundleID == "com.spotify.client" {
                    spotifyOpen = true
                }
            }
        }
        
        // If they are then grab the tracks and artists
        
        if iTunesOpen {
            if let iTunes = SBApplication(bundleIdentifier: "com.apple.iTunes") as? AnyObject {
                if let track = iTunes.valueForKey("currentTrack") {
                    if let name = track.valueForKey("name") as? String, artist = track.valueForKey("artist") as? String {
                        string = "🎵 \(artist) - \(name)"
                        self.track = string
                    }
                }
            }
        }
        
        if spotifyOpen {
            if string == nil {
                if let spotify = SBApplication(bundleIdentifier: "com.spotify.client") as? AnyObject {
                    if let track = spotify.valueForKey("currentTrack") {
                        if let name = track.valueForKey("name") as? String, artist = track.valueForKey("artist") as? String {
                            string = "🎵 \(artist) - \(name)"
                            self.track = string
                        }
                    }
                }
            }
        }
        
        if string == nil {
            string = "🎵 Nothing Playing"
        }
        
        super.init(string: string!, textView: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
