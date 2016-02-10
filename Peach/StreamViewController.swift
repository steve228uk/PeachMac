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
    
    @IBOutlet weak var loadingView: ConnectionsLoadingView!
    
    var firstLoad = true
    
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
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        collectionViewLayout.invalidateLayout()
    }
    
    func reloadAndScroll() {
        
        loadingView.hidden = false
        loadingView.loadingIndicator.startAnimation(self)
        
        
        if !firstLoad {
        
            self.collectionView.performBatchUpdates({
                
                var paths: Set<NSIndexPath> = []
                for section in 0...self.posts.count-1 {
                    self.collectionView.insertSections(NSIndexSet(index: section))
                    let item = self.posts[section].message.count-1
                    paths.insert(NSIndexPath(forItem: item, inSection: section))
                }
                
                self.collectionView.insertItemsAtIndexPaths(paths)
                
            }) { complete in
                
                if complete {
                    let section = self.posts.count-1
                    let item = self.posts[section].message.count
                    dispatch_async(dispatch_get_main_queue()) {
                        self.collectionView.selectItemsAtIndexPaths([NSIndexPath(forItem: item, inSection: section)], scrollPosition: .Bottom)
                        self.loadingView.loadingIndicator.stopAnimation(self)
                        self.loadingView.hideWithAnimation()
                    }
                }
                
            }
            
        } else {
            collectionView.reloadData()
            firstLoad = false
            let section = self.posts.count-1
            let item = self.posts[section].message.count
            collectionView.selectItemsAtIndexPaths([NSIndexPath(forItem: item, inSection: section)], scrollPosition: .Bottom)
            loadingView.loadingIndicator.stopAnimation(self)
            self.loadingView.hideWithAnimation()
        }
        

        
    }
    
    // MARK: - PeachMainWindowControllerDelegate
    
    func sendNavigationBack(sender: AnyObject?) {
        
        container?.toolbar?.backButton.hidden = true
        container?.toolbar?.title = "Friends"
        container?.toolbar?.borderVisible = true
        container?.toolbar?.delegate = parentViewController as? PeachNavigationDelegate
        
        stream = nil
        collectionView.reloadData()
        
        dismissViewController(self)
    }
    
    
}
