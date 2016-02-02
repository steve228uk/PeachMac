//
//  NSAttributedString+RemoveLastWord.swift
//  Peach
//
//  Created by Stephen Radford on 02/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension NSAttributedString {
    
    func attributedStringByRemovingLastWord() -> NSAttributedString {
        
        let lines = string.componentsSeparatedByString("\n")
        if let words = lines.last?.componentsSeparatedByString(" ") {
            if let last = words.last {
                return attributedSubstringFromRange(NSMakeRange(0, self.length - last.characters.count))
            }
        }

        return self
    }
    
}