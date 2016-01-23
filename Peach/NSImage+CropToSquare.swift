//
//  NSImage+ProportionalScaling.swift
//  Peach
//
//  Created by Stephen Radford on 23/01/2016.
//  Adapted from: https://gist.github.com/hcatlin/180e81cd961573e3c54d
//

import Cocoa

extension NSImage {
    
    var CGImage: CGImageRef? {
        get {
            var imageRect = CGRectMake(0, 0, size.width, size.height)
            return CGImageForProposedRect(&imageRect, context: nil, hints: nil)
        }
    }
    
    func cropToSquare() -> NSImage? {
        
        let originalWidth  = size.width
        let originalHeight = size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        let posX = (originalWidth  - edge) / 2.0
        let posY = (originalHeight - edge) / 2.0
        
        let cropSquare = CGRectMake(posX, posY, edge, edge)
        
        if let imageRef = CGImageCreateWithImageInRect(CGImage, cropSquare) {
            return NSImage(CGImage: imageRef, size: cropSquare.size)
        }
        
        return nil
        
    }
    
}
