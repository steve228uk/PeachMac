//
//  PeachPlayerView.swift
//  Peach
//
//  Created by Stephen Radford on 22/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import AVKit

class PeachPlayerView: AVPlayerView {

    override func scrollWheel(theEvent: NSEvent) {
        nextResponder?.scrollWheel(theEvent)
    }
    
}
