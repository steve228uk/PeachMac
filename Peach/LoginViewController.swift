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
        
        emailField.becomeFirstResponder()
    }
    
    @IBAction func login(sender: AnyObject) {
        
        User.authenticateWithCredentials((email: emailField.stringValue, password: passwordField.stringValue)) { result, error in
            if result != nil {
                Swift.print(result!.token)
                
                keychain["token"] = result!.token
                keychain["streamID"] = result!.streamID
                
                self.performSegueWithIdentifier("login", sender: sender)
            } else {
                // handle login error
            }
        }
        
    }
    
}
