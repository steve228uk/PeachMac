//
//  GIFAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 08/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import GiphyKit

class GIFAttachment: NSTextAttachment {

    var textView: NSTextView?
    
    init(gifs: [GIF], textView: NSTextView) {
        super.init(data: nil, ofType: nil)
        self.textView = textView
        if gifs.count > 0 {
            attachmentCell = GIFAttachmentCell(gifs: gifs, textView: textView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
