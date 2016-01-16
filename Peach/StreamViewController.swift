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
    
    var streamID: String? {
        didSet {
            headerView.nameLabel.stringValue = ""
            stream = nil
            collectionView.reloadData()
            loadStream()
        }
    }
    
    var stream: Stream?
    
    var posts: [Post] {
        get {
            if stream != nil {
                return stream!.posts.reverse()
            }
            return []
        }
    }
    
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
        collectionView.registerNib(NSNib(nibNamed: "PostGIFItem", bundle: nil), forItemWithIdentifier: "GIFItem")
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let name = stream?.displayName {
            headerView.nameLabel.stringValue = name
            collectionView.reloadData()
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.toolbar?.insertItemWithItemIdentifier("back", atIndex: 0)
        if let window = view.window?.windowController as? PeachMainWindowController {
            window.delegate = self
        }
    }
    
    override func viewDidDisappear() {
        stream = nil
        collectionView.reloadData()
        headerView.nameLabel.stringValue = ""
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
                }
            }
        }
    }
    
    func sendNavigationBack(sender: AnyObject?) {
        tabController?.selectedTabViewItemIndex = 0
    }
    
    
    // MARK: - NSCollectionViewDatasource & Delegate
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts[section].message.count
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        
        let message = posts[indexPath.section].message[indexPath.item]
        switch message.type! {
        case .Image, .GIF:
            
            guard message.width != nil else {
                return CGSizeMake(collectionView.frame.size.width-30, 80)
            }
            
            let width = CGFloat(message.width!)
            let height = CGFloat(message.height!)
            let calculatedHeight = (collectionView.frame.size.width-30) * height / width
            
            return CGSizeMake(collectionView.frame.size.width-30, calculatedHeight)
        default:
            return CGSizeMake(collectionView.frame.size.width-30, 80)
        }
        
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        
        let message = posts[indexPath.section].message[indexPath.item]
        
        switch message.type! {
        case .Text:
            let item = collectionView.makeItemWithIdentifier("textItem", forIndexPath: indexPath) as! PostTextItem
            if let text = message.text {
                item.textLabel.stringValue = text
            }
            return item
        case .Image:
            let item = collectionView.makeItemWithIdentifier("imageItem", forIndexPath: indexPath) as! PostImageItem
            item.imageView?.image = nil
            message.getImage { image in
                item.imageView?.image = image
            }
            return item
        case .GIF:
            let item = collectionView.makeItemWithIdentifier("GIFItem", forIndexPath: indexPath) as! PostGIFItem
            item.imageURL = message.src
            return item
        default:
            let item = collectionView.makeItemWithIdentifier("textItem", forIndexPath: indexPath) as! PostTextItem
            return item
        }
        
        
    }
    
}
