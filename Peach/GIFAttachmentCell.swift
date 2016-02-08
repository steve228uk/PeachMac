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
    
    let player = GIFPlayer(frame: NSZeroRect)
    
    var delegate: GIFAttachmentCellDelegate?
    
    convenience init(gifs: [GIF], textView: NSTextView?) {
        self.init(textCell: "")
        self.gifs = gifs
        self.textView = textView
    }
    
    override func drawWithFrame(cellFrame: NSRect, inView controlView: NSView?) {
        
        
        NSColor.init(hue: 0, saturation: 0, brightness: 0.9, alpha: 1).setStroke()
        let insetRect = NSInsetRect(cellFrame, 1, 1)
        let path = NSBezierPath(roundedRect: insetRect, xRadius: 5, yRadius: 5)
        path.lineWidth = 2
        path.stroke()
        
        let img = gifs[0].images[0]
        let height = CGFloat(img.height!)
        let width = CGFloat(img.width!)
        let calculatedHeight = (cellFrame.size.width) * height / width
        
        let imgRect = NSRect(x: cellFrame.origin.x, y: cellFrame.origin.y, width: cellFrame.size.width, height: calculatedHeight)
        let insetRect2 = NSInsetRect(imgRect, 10, 10)
        
        player.frame = insetRect2
        player.imageData = NSData(contentsOfURL: NSURL(string: img.url!)!)
        player.animationLayer.removeFromSuperlayer()
        player.animationLayer.frame = insetRect2
        controlView?.layer?.addSublayer(player.animationLayer)
        
        delegate?.animationLayer = player.animationLayer
        delegate?.imageData = player.imageData
        
    }
    
    override func cellSize() -> NSSize {
        
        var size = NSZeroSize
        if let view = textView {
            
            size.width = view.frame.size.width
            
            let img = gifs[0].images[0]
            let height = CGFloat(img.height!)
            let width = CGFloat(img.width!)
            let calculatedHeight = (size.width-20) * height / width
            size.height = calculatedHeight
        }
        
        return size
    }
    
}
