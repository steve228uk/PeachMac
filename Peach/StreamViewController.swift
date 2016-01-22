//
//  StreamViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class StreamViewController: NSViewController, PeachMainWindowControllerDelegate {
    
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
        collectionView.registerNib(NSNib(nibNamed: "PostVideoItem", bundle: nil), forItemWithIdentifier: "videoItem")
        collectionView.registerNib(NSNib(nibNamed: "PostLocationItem", bundle: nil), forItemWithIdentifier: "locationItem")
        collectionView.registerNib(NSNib(nibNamed: "PostLinkItem", bundle: nil), forItemWithIdentifier: "linkItem")
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
    
    
}
