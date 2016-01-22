//
//  String+EstimatedHeight.swift
//  Peach
//
//  Created by Stephen Radford on 17/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension String {
    
    /**
     Get the calculated height based on the size of the font and width of the container
     
     - parameter font:  The font used
     - parameter width: The width of the container
     
     - returns: The calculated height
     */
    func calculatedHeightForFont(font: NSFont, width: CGFloat) -> CGFloat {
        let textStorage = NSTextStorage(string: self)
        let textContainer = NSTextContainer(size: CGSize(width: width, height: CGFloat(FLT_MAX)))
        let layoutManager = NSLayoutManager()
        
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textStorage.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, textStorage.length))
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 2
        textStorage.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, textStorage.length))
        
        textContainer.lineFragmentPadding = 0
        
        layoutManager.glyphRangeForTextContainer(textContainer)
        
        
        return layoutManager.usedRectForTextContainer(textContainer).size.height
    }
    
}