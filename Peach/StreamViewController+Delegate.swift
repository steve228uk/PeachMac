//
//  StreamViewController+Delegate.swift
//  Peach
//
//  Created by Stephen Radford on 11/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension StreamViewController: NSCollectionViewDelegate {
    
    // Clean up the collectionview when cells go out of view
    
    func collectionView(collectionView: NSCollectionView, didEndDisplayingItem item: NSCollectionViewItem, forRepresentedObjectAtIndexPath indexPath: NSIndexPath) {
        
        if let i = item as? PostGIFItem {
            i.gifPlayer.imageData = nil
        } else if let i = item as? PostVideoItem {
            i.videoPlayer.player?.replaceCurrentItemWithPlayerItem(nil)
            i.videoPlayer.player = nil
        } else if let i = item as? PostImageItem {
            i.imageView?.image = nil
        }
        
    }
    
}
