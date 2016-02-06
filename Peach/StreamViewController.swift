//
//  StreamViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class StreamViewController: PeachViewController, PeachNavigationDelegate {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet weak var collectionViewLayout: NSCollectionViewFlowLayout!
    
    @IBOutlet weak var headerView: StreamHeaderView!
    
    @IBOutlet weak var scrollView: NSScrollView!
    
    var stream: Stream? {
        didSet {
            stream?.markAsRead()
        }
    }
    
    var posts: [Post] {
        get {
            if stream != nil {
                return stream!.posts.reverse()
            }
            return []
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(NSNib(nibNamed: "PostTextItem", bundle: nil), forItemWithIdentifier: "textItem")
        collectionView.registerNib(NSNib(nibNamed: "PostImageItem", bundle: nil), forItemWithIdentifier: "imageItem")
        collectionView.registerNib(NSNib(nibNamed: "PostGIFItem", bundle: nil), forItemWithIdentifier: "GIFItem")
        collectionView.registerNib(NSNib(nibNamed: "PostActionsItem", bundle: nil), forItemWithIdentifier: "actionsItem")
        collectionView.registerNib(NSNib(nibNamed: "PostVideoItem", bundle: nil), forItemWithIdentifier: "videoItem")
        collectionView.registerNib(NSNib(nibNamed: "PostLocationItem", bundle: nil), forItemWithIdentifier: "locationItem")
        collectionView.registerNib(NSNib(nibNamed: "PostLinkItem", bundle: nil), forItemWithIdentifier: "linkItem")
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        container?.toolbar?.backButton.hidden = false
        container?.toolbar?.title = ""
        container?.toolbar?.borderVisible = false
        container?.toolbar?.delegate = self
        
        if let name = stream?.displayName {
            headerView.nameLabel.stringValue = name
        }
        
        reloadAndScroll()
        
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        collectionViewLayout.invalidateLayout()
    }
    
    func reloadAndScroll() {
        dispatch_async(dispatch_get_main_queue()) {
            self.collectionView.reloadData()
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.collectionView.scrollPoint(NSPoint(x: 0, y: self.collectionView.frame.height))
        }
    }
    
    
    // MARK: - PeachMainWindowControllerDelegate
    
    func sendNavigationBack(sender: AnyObject?) {
        
        container?.toolbar?.backButton.hidden = true
        container?.toolbar?.title = "Friends"
        container?.toolbar?.borderVisible = true
        container?.toolbar?.delegate = parentViewController as? PeachNavigationDelegate
        
        dismissViewController(self)
    }
    
    
}
