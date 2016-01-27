//
//  PeachContainerViewController + MoveButtons.swift
//  Peach
//
//  Created by Stephen Radford on 27/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension PeachContainerViewController {
    
    func moveButtons() {
        if let btn = view.window?.standardWindowButton(.CloseButton) {
            btn.removeFromSuperview()
            btn.setFrameOrigin(NSPoint(x: 12, y: view.frame.size.height-28))
            view.addSubview(btn)
        }
        
        if let btn = view.window?.standardWindowButton(.MiniaturizeButton) {
            btn.removeFromSuperview()
            btn.setFrameOrigin(NSPoint(x: 32, y: view.frame.size.height-28))
            view.addSubview(btn)
        }
        
        if let btn = view.window?.standardWindowButton(.ZoomButton) {
            btn.removeFromSuperview()
            btn.setFrameOrigin(NSPoint(x: 52, y: view.frame.size.height-28))
            view.addSubview(btn)
        }
        
        if let btn = view.window?.standardWindowButton(.FullScreenButton) {
            btn.removeFromSuperview()
            btn.setFrameOrigin(NSPoint(x: 52, y: view.frame.size.height-28))
            view.addSubview(btn)
        }
    }
    
}