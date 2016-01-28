//
//  NSView+HideWithAnimation.swift
//  Peach
//
//  Created by Stephen Radford on 28/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension NSView {
    
    func hideWithAnimation() {
        NSAnimationContext.runAnimationGroup(fadeOut) {
            self.hidden = true
        }
    }
    
    func fadeOut(context: NSAnimationContext) {
        context.duration = 0.5
        animator().alphaValue = 0
    }
    
}
