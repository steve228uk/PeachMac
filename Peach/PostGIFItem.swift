//
//  PostGIFItem.swift
//  Peach
//
//  Created by Stephen Radford on 16/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import WebKit

class PostGIFItem: NSCollectionViewItem, WebUIDelegate {

    let blankRequest = NSURLRequest(URL: NSURL(string: "about:blank")!)
    let path = NSBundle.mainBundle().pathForResource("PostGIFTemplate", ofType: "html")
    
    @IBOutlet weak var webView: WebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.UIDelegate = self
        webView.editingDelegate = self
    }
    
    var imageURL: String? {
        didSet {
            
            webView.mainFrame.loadRequest(blankRequest)
            webView.mainFrame.frameView.allowsScrolling = false
            
            if let url = imageURL {
                do {
                    if let fp = path {
                        let content = try String(contentsOfFile: fp)
                        let replaced = content.stringByReplacingOccurrencesOfString("%IMAGEURL%", withString: url)
                        webView.mainFrame.loadHTMLString(replaced, baseURL: NSURL(string: fp.URLString))
                    }
                } catch {
                    Swift.print("Could not load template file")
                }
            }
            
        }
    }
    
    // MARK: - WebView
    
    func webView(sender: WebView!, contextMenuItemsForElement element: [NSObject : AnyObject]!, defaultMenuItems: [AnyObject]!) -> [AnyObject]! {
        return []
    }
    
    override func webView(webView: WebView!, shouldChangeSelectedDOMRange currentRange: DOMRange!, toDOMRange proposedRange: DOMRange!, affinity selectionAffinity: NSSelectionAffinity, stillSelecting flag: Bool) -> Bool {
        return false
    }
    
    func webView(webView: WebView!, dragSourceActionMaskForPoint point: NSPoint) -> Int {
        return 0
    }
    
    func webView(webView: WebView!, dragDestinationActionMaskForDraggingInfo draggingInfo: NSDraggingInfo!) -> Int {
        return 0
    }
    
}
