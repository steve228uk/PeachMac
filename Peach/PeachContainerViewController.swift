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

class PeachContainerViewController: NSViewController {
    
    @IBOutlet weak var container: NSView!
    
    var toolbar: PeachToolbarViewController?
    
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
            
            if let id = Peach.streamID {
                Peach.getStreamByID(id) { stream, error in
                    stream?.getAvatar { image in
                        self.avatar.image = image.cropToSquare()
                    }
                }
            }
            
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
    
}
