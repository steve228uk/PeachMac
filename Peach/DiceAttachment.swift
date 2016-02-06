//
//  DiceAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class DiceAttachment: PeachTextAttachment {

    init(textView: NSTextView?) {
        let string = "🎲 \(Int(arc4random_uniform(6) + 1)) 🎲 \(Int(arc4random_uniform(6) + 1))"
        super.init(string: string, textView: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
