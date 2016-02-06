//
//  DateAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class DateAttachment: PeachTextAttachment {

    init(textView: NSTextView?) {
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, d MMM YYYY")
        let dateString = dateFormatter.stringFromDate(date)
        let string = "📰 \(dateString)"
        super.init(string: string, textView: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
