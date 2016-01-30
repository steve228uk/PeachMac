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
    
    var message: ImageMessage? {
        didSet {
            gifPlayer.imageData = nil
            if let src = message?.src {
                Alamofire.request(.GET, src)
                    .responseData { response in
                        if let data = response.result.value {
                            self.gifPlayer.imageData = data
                        }
                    }
            }
        }
    }
    
    
}
