//
//  LoginViewController.swift
//  Peach
//
//  Created by Stephen Radford on 10/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit

class LoginViewController: NSViewController {

    @IBOutlet weak var emailField: NSTextField!
    
    @IBOutlet weak var passwordField: NSSecureTextField!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.titlebarAppearsTransparent = true
        view.window?.movableByWindowBackground  = true
        view.window?.toolbar?.visible = false
        
        emailField.becomeFirstResponder()
    }
    
    @IBAction func login(sender: AnyObject) {
        
        User.authenticateWithCredentials((email: emailField.stringValue, password: passwordField.stringValue)) { result, error in
            if result != nil {
                keychain["token"] = result!.token
                keychain["streamID"] = result!.streamID
                
                Peach.OAuthToken = result!.token
                Peach.streamID = result!.streamID
                
                // TODO: Change this for a segue. Hacky hack!
                let sb = NSStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateControllerWithIdentifier("connections") as? ConnectionsViewController
                let window = NSApplication.sharedApplication().windows[0]
                window.contentViewController = vc
                window.titleVisibility = .Hidden
                window.titlebarAppearsTransparent = false
                window.movableByWindowBackground  = false
                window.toolbar?.visible = true
                
            } else {
                // handle login error
            }
        }
        
    }
    
}
