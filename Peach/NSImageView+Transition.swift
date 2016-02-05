//
//  NSImageView+Transition.swift
//  Peach
//
//  Created by Stephen Radford on 05/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension NSImageView {
    
    func transitionWithImage(image: NSImage) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        wantsLayer = true
        layer?.addAnimation(transition, forKey: kCATransition)
        self.image = image
    }
    
}