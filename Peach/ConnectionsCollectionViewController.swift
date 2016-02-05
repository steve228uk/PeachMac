//
//  ConnectionsCollectionViewController.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit
import GiphyKit

class ConnectionsCollectionViewController: PeachViewController, PeachContainerDelegate, NSCollectionViewDelegateFlowLayout, NSCollectionViewDataSource {

    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet weak var collectionViewLayout: NSCollectionViewFlowLayout!
    
    @IBOutlet weak var loadingView: ConnectionsLoadingView!
    
    /// The streams that were fetched from Peach
    var streams: [Stream] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.loadingIndicator.startAnimation(self)

        collectionView.registerNib(NSNib(nibNamed: "ConnectionCollectionViewItem", bundle: nil), forItemWithIdentifier: "connectionItem")
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        container?.toolbar?.backButton.hidden = true
        container?.toolbar?.title = "Friends"
        container?.toolbar?.borderVisible = true
        container?.delegate = self
        
        loadStreams()
        
        view.window?.toolbar?.removeItemAtIndex(0)
    }
    
    func successfullyLoggedIn() {
        loadStreams()
    }
    
    func loadStreams() {
        Peach.getStreams { streams, error in
            self.streams = streams
            self.collectionView.reloadData()
            if error == nil {
                self.loadingView.hideWithAnimation()
            }
        }
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
                    vc.stream = stream
                    tc.selectedTabViewItemIndex = 1
                    vc.reloadAndScroll()
                }
            }
        }
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        return CGSizeMake(collectionView.frame.size.width, 80)
    }
    
}
