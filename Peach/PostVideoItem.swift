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

    @IBOutlet weak var videoPlayer: PeachPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.peachGreyColor().CGColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoPlayer.player?.replaceCurrentItemWithPlayerItem(nil)
        videoPlayer.player = nil
    }
    
    var videoURL: String? {
        didSet {
            if let url = NSURL(string: videoURL!) where videoURL != nil {
                let player = AVPlayer(URL: url)
                videoPlayer.player = player
            } else {
                videoPlayer.player = nil
            }
        }
    }

    
}
