//
//  ConnectionsCollectionViewController.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ConnectionsCollectionViewController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {

    @IBOutlet weak var collectionView: NSCollectionView!
    
    /// The streams that were fetched from Peach
    var streams: [Stream] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(NSNib(nibNamed: "ConnectionCollectionViewItem", bundle: nil), forItemWithIdentifier: "connectionItem")
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()

        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        Peach.getStreams { streams, error in
            self.streams = streams
            self.collectionView.reloadData()
        }
        
        view.window?.toolbar?.removeItemAtIndex(0)
    }
    
    
    // MARK: - NSCollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return streams.count
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItemWithIdentifier("connectionItem", forIndexPath: indexPath) as! ConnectionCollectionViewItem
        item.stream = streams[indexPath.item]
        return item
    }
    
    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        if indexPaths.count == 1 {
            if let tc = parentViewController as? PeachTabViewController {
                if let vc = tc.childViewControllers[1] as? StreamViewController {
                    let item = indexPaths[indexPaths.startIndex].item
                    let stream = streams[item]
                    vc.streamID = stream.id
                    tc.selectedTabViewItemIndex = 1
                }
            }
        }
    }
    
}
