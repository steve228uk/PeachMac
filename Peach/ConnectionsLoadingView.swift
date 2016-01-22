//
//  ConnectionsLoadingView.swift
//  Peach
//
//  Created by Stephen Radford on 22/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class ConnectionsLoadingView: ConnectionsView {

    @IBOutlet weak var loadingIndicator: NSProgressIndicator!
    
    func hideWithAnimation() {
        NSAnimationContext.runAnimationGroup(fadeOut) {
            self.hidden = true
        }
    }
    
    func fadeOut(context: NSAnimationContext) {
        context.duration = 0.3
        animator().alphaValue = 0
    }
    
}
