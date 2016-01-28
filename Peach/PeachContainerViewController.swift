//
//  PeachContainerViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import KeychainAccess
import PeachKit

@objc protocol PeachContainerDelegate {
    optional func successfullyLoggedIn()
}

class PeachContainerViewController: NSViewController {
    
    @IBOutlet weak var container: NSView!
    
    @IBOutlet weak var tabBar: NSVisualEffectView!
    
    var toolbar: PeachToolbarViewController?
    
    var delegate: PeachContainerDelegate?
    
    // MARK: - Login Controller
    
    var loginController: LoginViewController?
    
    var loginObjects: NSArray? = []
    
    // MARK: - Tab Bar Icons
    
    @IBOutlet weak var avatar: AvatarView!
    
    @IBOutlet weak var friendsBtn: NSButton!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = keychain["token"]
        streamID = keychain["streamID"]
        
        if token != nil {
            
            Peach.OAuthToken = token
            Peach.streamID = streamID
            
            loadUserStream()
            
        } else {
            loadLoginView()
        }
        
    }
    
    
    override func viewDidLayout() {
        super.viewDidLayout()
        moveButtons()
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationController as? PeachToolbarViewController {
            toolbar = vc
        }
    }
    
    // MARK: - Network
    
    func loadUserStream() {
        if let id = Peach.streamID {
            Peach.getStreamByID(id) { stream, error in
                if let src = stream?.avatarSrc {
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        let image = NSImage(byReferencingURL: NSURL(string: src)!).cropToSquare()
                        dispatch_async(dispatch_get_main_queue()) {
                            self.avatar.image = image
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Tab Bar Actions
    
    @IBAction func showFriends(sender: AnyObject) {
    }
    
    @IBAction func showActivity(sender: AnyObject) {
    }
    
    @IBAction func showProfile(sender: AnyObject) {
    }
}
