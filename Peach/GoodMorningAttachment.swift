//
//  GoodMorningAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class GoodMorningAttachment: PeachTextAttachment {

    init(textView: NSTextView?) {
        let date = NSDate()
        let string = "Good morning! 🌤\n\n\(String(format: "%02d", date.hour())):\(String(format: "%02d", date.minute()))"
        super.init(string: string, textView: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
