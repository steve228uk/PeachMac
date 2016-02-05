//
//  FadingImageView.swift
//  Peach
//
//  Created by Stephen Radford on 05/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class FadingImageView: NSImageView {
    
    override var image: NSImage? {
        willSet {
            if image == nil {
                addFadingAnimation()
            }
        }
    }
    
    func addFadingAnimation() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        wantsLayer = true
        layer?.addAnimation(transition, forKey: kCATransition)
    }
    
}
