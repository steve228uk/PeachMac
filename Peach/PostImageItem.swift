//
//  PostImageItem.swift
//  Peach
//
//  Created by Stephen Radford on 16/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import WebKit

class PostImageItem: NSCollectionViewItem {
    
    let blankRequest = NSURLRequest(URL: NSURL(string: "about:blank")!)
    
    @IBOutlet weak var webView: WebView!
    
    var imageURL: String? {
        didSet {
            
            webView.mainFrame.loadRequest(blankRequest)
            
            if let url = imageURL {
                let request = NSURLRequest(URL: NSURL(string: url)!)
                webView.mainFrame.loadRequest(request)
            }
        }
    }
    
}
