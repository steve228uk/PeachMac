//
//  GIFSearch.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import GiphyKit

class GIFSearch: MagicInputHandler {
    
    override func handleAction(input: String) {
        Giphy.search(input) { gifs, error in
            let attachment = GIFAttachment(gifs: gifs, textView: self.textView)
            self.delegate?.appendDeferredAttachment(attachment)
        }
    }
    
}