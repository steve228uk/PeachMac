//
//  PostGIFItem.swift
//  Peach
//
//  Created by Stephen Radford on 16/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import WebKit

class PostGIFItem: NSCollectionViewItem {

    let blankRequest = NSURLRequest(URL: NSURL(string: "about:blank")!)
    let path = NSBundle.mainBundle().pathForResource("PostGIFTemplate", ofType: "html")
    
    @IBOutlet weak var webView: WebView!
    
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
    
}
