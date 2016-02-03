//
//  PeachTextOptionsAttachmentCell.swift
//  Peach
//
//  Created by Stephen Radford on 03/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class PeachTextOptionsAttachmentCell: NSTextAttachmentCell {

    var options: [String]?
    var currentIndex = 0
    var textView: NSTextView?
    
    let leftButton = NSButton(frame: NSZeroRect)
    let rightButton = NSButton(frame: NSZeroRect)
    let label = NSTextField(frame: NSZeroRect)
    
    convenience init(textCell: String, textView: NSTextView?) {
        self.init(textCell: textCell)
        self.textView = textView
    }
    
    override func drawWithFrame(cellFrame: NSRect, inView controlView: NSView?) {
        
        NSColor.init(hue: 0, saturation: 0, brightness: 0.9, alpha: 1).setStroke()
        let insetRect = NSInsetRect(cellFrame, 1, 1)
        let path = NSBezierPath(roundedRect: insetRect, xRadius: 5, yRadius: 5)
        path.lineWidth = 2
        path.stroke()
        
        leftButton.cell = AttachmentButtonCell(textCell: "<")
        rightButton.cell = AttachmentButtonCell(textCell: ">")
        
        if let view = controlView {
            label.attributedStringValue = attributedStringValue
            label.bordered = false
            label.drawsBackground = false
            let insetRect = NSInsetRect(cellFrame, 20, 5)
            label.cell?.drawWithFrame(insetRect, inView: view)
            
            leftButton.cell?.drawWithFrame(NSRect(x: cellFrame.origin.x, y: cellFrame.origin.y, width: 20, height: 20), inView: view)
            rightButton.cell?.drawWithFrame(NSRect(x: cellFrame.origin.x+cellFrame.size.width-25, y: cellFrame.origin.y, width: 20, height: 20), inView: view)
        }
        
    }
    
    override func cellSize() -> NSSize {
        
        if let view = textView {
            return NSMakeSize(view.frame.size.width, 40)
        }
        
        return NSZeroSize
    }
    
    override func trackMouse(theEvent: NSEvent, inRect cellFrame: NSRect, ofView controlView: NSView?, untilMouseUp flag: Bool) -> Bool {
    
        if let view = controlView {
            
            let rightRect = NSRect(x: cellFrame.origin.x, y: cellFrame.origin.y, width: 20, height: 20)
            let rightHitType = hitTestForEvent(theEvent, inRect: rightRect, ofView: view)
            let rightButtonClick = (rightHitType == NSCellHitResult.ContentArea || rightHitType == NSCellHitResult.TrackableArea)
            
            let leftRect = NSRect(x: cellFrame.origin.x, y: cellFrame.origin.y, width: 20, height: 20)
            let leftHitType = hitTestForEvent(theEvent, inRect: leftRect, ofView: view)
            let leftButtonClick = (leftHitType == NSCellHitResult.ContentArea || leftHitType == NSCellHitResult.TrackableArea)
            
            if rightButtonClick {
                currentIndex++
                if currentIndex >= options!.count {
                    currentIndex = 0
                }
                
                if let attachment = attachment as? PeachTextOptionsAttachment {
                    attachment.text = options![currentIndex]
                }
                
                stringValue = options![currentIndex]
                view.setNeedsDisplayInRect(cellFrame)
            }
            
            if leftButtonClick {
                currentIndex--
                if currentIndex == -1 {
                    currentIndex = options!.count-1
                }
                
                if let attachment = attachment as? PeachTextOptionsAttachment {
                    attachment.text = options![currentIndex]
                }
                
                stringValue = options![currentIndex]
                view.setNeedsDisplayInRect(cellFrame)
            }
            
            
        }
        
        return true
    }
    
}
