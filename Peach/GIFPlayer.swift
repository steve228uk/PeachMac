//
//  GIFPlayer.swift
//  Peach
//
//  Created by Stephen Radford on 30/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//  Adapted from Byte Inc's Objective-C implemenation
//

import Cocoa

enum GIFPlayerScaleType {
    case Fill
    case Fit
}

class GIFPlayer: NSView {

    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    
    /// The image data that will be converted into animation
    var imageData: NSData? {
        didSet {
            if let data = imageData {
                
                
                self.image = NSImage(data: data)
                
                guard let imageSource = CGImageSourceCreateWithData(data, nil) else {
                    Swift.print("Image source could not be loaded")
                    return
                }
                
                guard let imageSourceContainerType = CGImageSourceGetType(imageSource) else {
                    Swift.print("Container could not be created")
                    return
                }
                
                let isGIFData = UTTypeConformsTo(imageSourceContainerType, kUTTypeGIF)
                guard isGIFData else {
                    Swift.print("Image data is not a valid GIF")
                    return
                }
                
                if let img = self.image {
                    let reps = img.representations
                    
                    for rep in reps {
                        if let bitmapRep = rep as? NSBitmapImageRep {
                            
                            guard let frameCount = bitmapRep.valueForProperty(NSImageFrameCount) as? Int else {
                                break
                            }
                            
                            // create an animation array which will contain all the frames of the animation
                            var values: [CGImage] = []
                            
                            // create an array of delay times which contain the time to delay between each frame
                            var delayTimes: [NSNumber] = []
                            
                            // we will increment this in our loop below to set total animation length
                            var animationDuration: NSTimeInterval = 0.0
                            
                            for var i = 0; i < frameCount; i++ {
                                
                                // set the current frame we're operating on
                                bitmapRep.setProperty(NSImageCurrentFrame, withValue: i)
                                
                                
                                let frameProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as NSDictionary?
                                let framePropertiesGIF = frameProperties?.objectForKey(kCGImagePropertyGIFDictionary)
                                
                                // Try to use the unclamped delay time; fall back to the normal delay time.
                                var delayTime = framePropertiesGIF?.objectForKey(kCGImagePropertyGIFDelayTime) as? NSNumber
                                if delayTime == 0 {
                                    delayTime = framePropertiesGIF?.objectForKey(kCGImagePropertyGIFDelayTime) as? NSNumber
                                }
                                
                                // If we don't get a delay time from the properties, fall back to `kDelayTimeIntervalDefault` or carry over the preceding frame's value.
                                let kDelayTimeIntervalDefault: NSTimeInterval = 0.1
                                
                                if delayTime == nil {
                                    if i == 0 {
                                        Swift.print("Falling back to default delay time for first frame, because a delay time was not found in GIF properties \(frameProperties)")
                                        delayTime = kDelayTimeIntervalDefault
                                    } else {
                                        Swift.print("Falling back to preceding delay time for frame #%d, because a delay time was not found in GIF properties \(frameProperties)")
                                        delayTime = delayTimes.last
                                    }
                                }
                                
                                delayTimes.append(delayTime!)
                                values.append(bitmapRep.CGImage!)
                                
                                animationDuration += delayTime!.doubleValue
                                
                            }
                            
                            let animation = CAKeyframeAnimation(keyPath: "contents")
                            animation.values = values
                            animation.calculationMode = "discrete"
                            animation.duration = animationDuration - delayTimes.last!.doubleValue
                            animation.repeatCount = Float.infinity
                            self.animationLayer.addAnimation(animation, forKey: "contents")
                            
                            break
                            
                        }
                    }
                    
                    
                    self.resizeSubviewsWithOldSize(self.frame.size)
                    
                }
                
                
            } else {
                image = nil
                animationLayer.removeAllAnimations()
            }
        }
    }
    
    var image: NSImage?
    
    var scaleType: GIFPlayerScaleType = .Fill
    
    /// CoreAnimation Layer
    var animationLayer: CALayer!
    
    override var flipped: Bool {
        get {
            return true
        }
    }
    
    
    // MARK: - Initializers
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        sharedInit()
    }
    
    func sharedInit() {
        wantsLayer = true
        layer?.anchorPoint = CGPointMake(0.5, 0.5)
        layer?.frame = frame
        animationLayer = CALayer()
        layer?.addSublayer(animationLayer)
    }
    
    
    override func resizeSubviewsWithOldSize(oldSize: NSSize) {
        super.resizeSubviewsWithOldSize(oldSize)
        
        if let img = image {
            if let l = layer {
                
                let containerAspect = l.bounds.size.width / l.bounds.size.height
                let imageAspect = img.size.width / img.size.height
                var ratio: CGFloat
                
                if scaleType == .Fill {
                    if containerAspect > imageAspect {
                        ratio = l.bounds.size.width / img.size.width
                    } else {
                        ratio = l.bounds.size.height / img.size.height
                    }
                } else {
                    if containerAspect > imageAspect {
                        ratio = l.bounds.size.height / img.size.height
                    } else {
                        ratio = l.bounds.size.width / img.size.width
                    }
                }
                
                let targetW = img.size.width * ratio
                let targetH = img.size.height * ratio
                let targetFrame = NSMakeRect(l.bounds.size.width / 2 - targetW / 2, l.bounds.size.height / 2 - targetH / 2, targetW, targetH)
                
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                animationLayer.frame = targetFrame
                CATransaction.commit()
                
            }
        }
        
    }

}
