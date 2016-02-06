//
//  GIFSearch.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import GiphyKit

class GIFSearch: MagicInputDelegate {
    
    func handleAction(input: String) {
        Giphy.search(input) { gifs, error in
            print(gifs)
        }
    }
    
}