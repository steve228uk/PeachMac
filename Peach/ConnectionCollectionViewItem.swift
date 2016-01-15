//
//  ConnectionCollectionViewItem.swift
//  Peach
//
//  Created by Stephen Radford on 14/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class ConnectionCollectionViewItem: NSCollectionViewItem {

    @IBOutlet weak var image: NSImageView!
    
    @IBOutlet weak var nameLabel: NSTextField!
    
    var stream: Stream? {
        didSet {
            nameLabel.stringValue = stream!.displayName!
            image.image = nil
            stream?.getAvatar { image in
                self.image.image = image
            }
        }
    }
    
}
