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
    
    @IBOutlet weak var scrollView: NSScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(NSNib(nibNamed: "PostTextItem", bundle: nil), forItemWithIdentifier: "textItem")
        collectionView.registerNib(NSNib(nibNamed: "PostImageItem", bundle: nil), forItemWithIdentifier: "imageItem")
        collectionView.registerNib(NSNib(nibNamed: "PostGIFItem", bundle: nil), forItemWithIdentifier: "GIFItem")
        collectionView.registerNib(NSNib(nibNamed: "PostActionsItem", bundle: nil), forItemWithIdentifier: "actionsItem")
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let name = stream?.displayName {
            headerView.nameLabel.stringValue = name
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.toolbar?.insertItemWithItemIdentifier("back", atIndex: 0)
        if let window = view.window?.windowController as? PeachMainWindowController {
            window.delegate = self
        }
        
        // This feels really hacky… But it works!
        // http://stackoverflow.com/questions/14020027/how-do-i-know-that-the-uicollectionview-has-been-loaded-completely
        
        dispatch_async(dispatch_get_main_queue()) {
            self.collectionView.reloadData()
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.scrollView.contentView.scrollPoint(NSPoint(x: 0, y: self.collectionView.frame.height))
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
    
    
    // MARK: - PeachMainWindowControllerDelegate
    
    func sendNavigationBack(sender: AnyObject?) {
        tabController?.selectedTabViewItemIndex = 0
    }
    
    
    // MARK: - NSCollectionViewDatasource & Delegate
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts[section].message.count + 1
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> NSSize {
        
        guard indexPath.item != posts[indexPath.section].message.count else {
            return CGSizeMake(collectionView.frame.size.width, 50)
        }
        
        let message = posts[indexPath.section].message[indexPath.item]
        
        switch message.type {
        case .Text:
            if let textMessage = message as? TextMessage {
                if let text = textMessage.text {
                    // Not sure why a font size of double is required?
                    let calculatedHeight = text.calculatedHeightForFont(NSFont.systemFontOfSize(14), width: collectionView.frame.size.width-40)
                    return CGSizeMake(collectionView.frame.size.width, calculatedHeight)
                }
            }
        case .Image, .GIF:
            
            if let imageMessage = message as? ImageMessage {
                guard imageMessage.width != nil else {
                    return CGSizeMake(collectionView.frame.size.width, 80)
                }
                
                let width = CGFloat(imageMessage.width!)
                let height = CGFloat(imageMessage.height!)
                let calculatedHeight = (collectionView.frame.size.width) * height / width
                
                return CGSizeMake(collectionView.frame.size.width, calculatedHeight)
            }
        default:
            return CGSizeMake(collectionView.frame.size.width, 20)
        }
        
        // final catch
        return CGSizeMake(collectionView.frame.size.width, 20)
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        
        guard indexPath.item != posts[indexPath.section].message.count else {
            let item = collectionView.makeItemWithIdentifier("actionsItem", forIndexPath: indexPath) as! PostActionsItem
            item.post = posts[indexPath.section]
            return item
        }

        
        let message = posts[indexPath.section].message[indexPath.item]
        
        switch message.type {
        case .Text:
            let item = collectionView.makeItemWithIdentifier("textItem", forIndexPath: indexPath) as! PostTextItem
            let textMessage = message as! TextMessage
            if let text = textMessage.text {
                item.textLabel.stringValue = text
            }
            return item
        case .Image:
            let item = collectionView.makeItemWithIdentifier("imageItem", forIndexPath: indexPath) as! PostImageItem
            let imageMessage = message as! ImageMessage
            item.imageView?.image = nil
            imageMessage.getImage { image in
                item.imageView?.image = image
            }
            return item
        case .GIF:
            let item = collectionView.makeItemWithIdentifier("GIFItem", forIndexPath: indexPath) as! PostGIFItem
            let imageMessage = message as! ImageMessage
            item.imageURL = imageMessage.src
            return item

        default:
            let item = collectionView.makeItemWithIdentifier("textItem", forIndexPath: indexPath) as! PostTextItem
            return item
        }
        
        
    }
    
    
    
}
