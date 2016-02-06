//
//  RatingAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class RatingAttachment: PeachTextOptionsAttachment {

    init(textView: NSTextView?) {
        
        let options = [
            "Rating: ⭐️⭐️⭐️⭐️⭐️ 5/5",
            "Rating: ⭐️ 1/5",
            "Rating: ⭐️⭐️ 2/5",
            "Rating: ⭐️⭐️⭐️ 3/5",
            "Rating: ⭐️⭐️⭐️⭐️ 4/5",
        ]
        
        super.init(options: options, textView: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}