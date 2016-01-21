//
//  PostVideoItem.swift
//  Peach
//
//  Created by Stephen Radford on 21/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation

class PostVideoItem: NSCollectionViewItem {

    @IBOutlet weak var videoPlayer: AVPlayerView!
    
    var videoURL: String? {
        didSet {
            if let url = NSURL(string: videoURL!) where videoURL != nil {
                let playerItem = AVPlayerItem(URL: url)
                videoPlayer.player?.replaceCurrentItemWithPlayerItem(playerItem)
            } else {
                videoPlayer.player?.replaceCurrentItemWithPlayerItem(nil)
            }
        }
    }
    
}
