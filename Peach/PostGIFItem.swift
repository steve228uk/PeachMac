//
//  PostGIFItem.swift
//  Peach
//
//  Created by Stephen Radford on 16/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit
import Alamofire

class PostGIFItem: NSCollectionViewItem {
    
    @IBOutlet weak var gifPlayer: GIFPlayer!
    
    @IBOutlet weak var poster: NSImageView!
    
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.peachGreyColor().CGColor
    }
    
    var message: ImageMessage? {
        didSet {
            gifPlayer.imageData = nil
            poster.image = nil
            if let src = message?.src {
                
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    
                    let image = NSImage(byReferencingURL: NSURL(string: src)!)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.poster.image = image
                    }
                    
                    self.message?.getImageData { data in
                         self.gifPlayer.imageData = data
                    }
                    
                }
                
                

            }
        }
    }
    
    
}
