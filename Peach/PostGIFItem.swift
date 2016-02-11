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
    
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.peachGreyColor().CGColor
    }
    
    override func prepareForReuse() {
        gifPlayer.imageData = nil
    }
    
    var message: ImageMessage? {
        didSet {
            gifPlayer.imageData = nil
  
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                
                self.message?.getImageData { data in
                    self.gifPlayer.imageData = data
                }
                
            }

        }
    }
    
    
}
