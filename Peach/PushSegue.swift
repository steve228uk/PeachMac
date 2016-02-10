//
//  PushSegue.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//
//  Adapted from https://github.com/insidegui/GRPushSegue/

import Cocoa

class PushSegue: NSStoryboardSegue {

    override func perform() {
        if let source = sourceController as? NSViewController {
            if let dest = destinationController as? NSViewController {
                source.presentViewController(dest, animator: PushSegueAnimator())
            }
        }
    }
    
}

class PushSegueAnimator: NSObject, NSViewControllerPresentationAnimator {
    
    func animatePresentationOfViewController(viewController: NSViewController, fromViewController: NSViewController) {
        
        viewController.view.frame = NSMakeRect(NSWidth(fromViewController.view.frame), 0, NSWidth(fromViewController.view.frame), NSHeight(fromViewController.view.frame))
        
        Swift.print(viewController)
        
        viewController.view.autoresizingMask = [.ViewWidthSizable, .ViewHeightSizable]
        fromViewController.view.addSubview(viewController.view)
        
        let destinationRect = fromViewController.view.frame
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            viewController.view.animator().frame = destinationRect
        }, completionHandler: nil)
        
    }
    
    func animateDismissalOfViewController(viewController: NSViewController, fromViewController: NSViewController) {
        
        let destinationRect = NSMakeRect(NSWidth(fromViewController.view.frame), 0, NSWidth(fromViewController.view.frame), NSHeight(fromViewController.view.frame))
        
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            viewController.view.animator().frame = destinationRect
        }, completionHandler: {
            viewController.view.removeFromSuperview()
        })
        
    }
    
}