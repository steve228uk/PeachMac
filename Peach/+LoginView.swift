//
//  +LoginView.swift
//  Peach
//
//  Created by Stephen Radford on 27/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension PeachContainerViewController: LoginDelegate {

    func loadLoginView() {
        
        tabBar.hidden = true // Hide the tab bar to avoid visual issues
        loginController = LoginViewController()
        
        if let nib = NSNib(nibNamed: "Login", bundle: nil) {
            nib.instantiateWithOwner(loginController, topLevelObjects: &loginObjects)
            if let vc = loginController {
                vc.delegate = self
                vc.view.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(vc.view)
                
                let views = ["login": vc.view]
                view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[login]|", options: [], metrics: nil, views: views))
                view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[login]|", options: [], metrics: nil, views: views))
            }
        }
        
    }
    
    func loggedInSuccessfully() {
        tabBar.hidden = false
        loadUserStream()
        delegate?.successfullyLoggedIn?()
        
        if let vc = loginController {
            NSAnimationContext.runAnimationGroup(vc.view.fadeOut) {
                vc.view.removeFromSuperview()
                self.loginController = nil
            }
        }
    }
    
}
