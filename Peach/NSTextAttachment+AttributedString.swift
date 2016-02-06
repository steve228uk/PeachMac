//
//  NSTextAttachment+AttributedString.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension NSTextAttachment {
    
    /// The attachment wrapped in an attributed string ready for appending
    var attributedString: NSAttributedString {
        get {
            return NSAttributedString(attachment: self)
        }
    }
    
}