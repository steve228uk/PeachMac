//
//  StreamViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class StreamViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate, PeachMainWindowControllerDelegate {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet weak var collectionViewLayout: NSCollectionViewFlowLayout!
    
    var streamID: String?
    
    var stream: Stream?
    
    var tabController: PeachTabViewController? {
        get {
           return parentViewController as? PeachTabViewController
        }
    }
    
    @IBOutlet weak var headerView: StreamHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(NSNib(nibNamed: "PostTextItem", bundle: nil), forItemWithIdentifier: "textItem")
        collectionView.registerNib(NSNib(nibNamed: "PostImageItem", bundle: nil), forItemWithIdentifier: "imageItem")
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.toolbar?.insertItemWithItemIdentifier("back", atIndex: 0)
        if let window = view.window?.windowController as? PeachMainWindowController {
            window.delegate = self
        }
        
        loadStream()
        
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        collectionViewLayout.invalidateLayout()
    }
    
    func loadStream() {
        if let id = streamID {
            Peach.getStreamByID(id) { stream, error in
                if let s = stream {
                    self.stream = s
                    self.collectionView.reloadData()
                    if let name = s.displayName {
                        self.headerView.nameLabel.stringValue = name
                    }
                }
            }
        }
    }
    
    func sendNavigationBack(sender: AnyObject?) {
        tabController?.selectedTabViewItemIndex = 0
    }
    
    
    // MARK: - NSCollectionViewDatasource & Delegate
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        if stream != nil {
            return stream!.posts.count
        }
        return 0
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if stream != nil {
            return stream!.posts[section].message.count
        }
        return 0
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        return CGSizeMake(collectionView.frame.size.width, 80)
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        
        let message = stream!.posts[indexPath.section].message[indexPath.item]
        
        switch message.type! {
        case .Text:
            let item = collectionView.makeItemWithIdentifier("textItem", forIndexPath: indexPath) as! PostTextItem
            if let text = message.text {
                item.textLabel.stringValue = text
            }
            return item
        case .Image, .GIF:
            let item = collectionView.makeItemWithIdentifier("imageItem", forIndexPath: indexPath) as! PostImageItem
            item.imageURL = message.src
            return item
        default:
            let item = collectionView.makeItemWithIdentifier("textItem", forIndexPath: indexPath) as! PostTextItem
            return item
        }
        
        
    }
    
}
