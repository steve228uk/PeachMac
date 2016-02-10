//
//  GIFAttachmentCell.swift
//  Peach
//
//  Created by Stephen Radford on 08/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import GiphyKit

class GIFAttachmentCell: NSTextAttachmentCell {
    
    var textView: NSTextView?
    
    var gifs: [GIF] = []
    
    var player: GIFPlayer! = GIFPlayer(frame: NSZeroRect)
    
    weak var delegate: GIFAttachmentCellDelegate?
    
    var currentIndex = 0
    
    let leftButton = NSButton(frame: NSZeroRect)
    
    let rightButton = NSButton(frame: NSZeroRect)
    
    convenience init(gifs: [GIF], textView: NSTextView?) {
        self.init(textCell: " ") // Oddly, mouse events won't be tracked correctly if this is not set as anything but a blank string
        self.gifs = gifs
        self.textView = textView
    }
    
    override func drawWithFrame(cellFrame: NSRect, inView controlView: NSView?) {
        
        
        NSColor.init(hue: 0, saturation: 0, brightness: 0.9, alpha: 1).setStroke()
        let insetRect = NSInsetRect(cellFrame, 1, 1)
        let path = NSBezierPath(roundedRect: insetRect, xRadius: 5, yRadius: 5)
        path.lineWidth = 2
        path.stroke()
        
        let img = gifs[currentIndex].images[0]
        let height = CGFloat(img.height!)
        let width = CGFloat(img.width!)
        let calculatedHeight = (cellFrame.size.width) * height / width
        
        let imgRect = NSRect(x: cellFrame.origin.x, y: cellFrame.origin.y, width: cellFrame.size.width, height: calculatedHeight)
        let insetRect2 = NSInsetRect(imgRect, 30, 10)
        
        player.frame = insetRect2
        player.imageData = NSData(contentsOfURL: NSURL(string: img.url!)!)
        player.animationLayer.removeFromSuperlayer()
        player.animationLayer.frame = insetRect2
        controlView?.layer?.addSublayer(player.animationLayer)
        
        delegate?.animationLayer = player.animationLayer
        delegate?.imageData = player.imageData
        
        leftButton.cell = AttachmentButtonCell(textCell: "<")
        rightButton.cell = AttachmentButtonCell(textCell: ">")
        
        if let view = controlView {
            leftButton.cell?.drawWithFrame(NSRect(x: cellFrame.origin.x+5, y: cellFrame.origin.y+8, width: 20, height: 20), inView: view)
            rightButton.cell?.drawWithFrame(NSRect(x: cellFrame.origin.x+cellFrame.size.width-25, y: cellFrame.origin.y+8, width: 20, height: 20), inView: view)
        }
        
    }
    
    override func cellSize() -> NSSize {
        
        var size = NSZeroSize
        if let view = textView {
            
            size.width = view.frame.size.width
            
            let img = gifs[currentIndex].images[0]
            let height = CGFloat(img.height!)
            let width = CGFloat(img.width!)
            let calculatedHeight = (size.width-20) * height / width
            size.height = calculatedHeight
        }
        
        return size
    }
    
    override func trackMouse(theEvent: NSEvent, inRect cellFrame: NSRect, ofView controlView: NSView?, untilMouseUp flag: Bool) -> Bool {
        
        if let view = controlView {
            
            let rightRect = NSRect(x: cellFrame.origin.x+cellFrame.size.width-25, y: cellFrame.origin.y+8, width: 20, height: 20)
            let rightHitType = hitTestForEvent(theEvent, inRect: rightRect, ofView: view)
            let rightButtonClick = (rightHitType == NSCellHitResult.ContentArea || rightHitType == NSCellHitResult.TrackableArea)
            
            let leftRect = NSRect(x: cellFrame.origin.x, y: cellFrame.origin.y, width: 20, height: 20)
            let leftHitType = hitTestForEvent(theEvent, inRect: leftRect, ofView: view)
            let leftButtonClick = (leftHitType == NSCellHitResult.ContentArea || leftHitType == NSCellHitResult.TrackableArea)
            
            if rightButtonClick {
                currentIndex++
                if currentIndex >= gifs.count {
                    currentIndex = 0
                }
            }
            
            if leftButtonClick {
                currentIndex--
                if currentIndex == -1 {
                    currentIndex = gifs.count-1
                }
            }

            view.needsLayout = true
            
            let newRect = NSRect(origin: cellFrame.origin, size: cellSize())
            view.setNeedsDisplayInRect(newRect)
            
        }
        
        return true
    }
    
    deinit {
        player = nil
    }
    
}
