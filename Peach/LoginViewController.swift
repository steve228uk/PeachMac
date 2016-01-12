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
                NSApplication.sharedApplication().windows[0].contentViewController = vc
            } else {
                // handle login error
            }
        }
        
    }
    
}
