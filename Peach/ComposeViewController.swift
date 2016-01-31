//
//  ComposeViewController.swift
//  Peach
//
//  Created by Stephen Radford on 12/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import PeachKit
import ImgurKit

class ComposeViewController: NSViewController {
    
    @IBOutlet var textView: PeachComposeTextView!
    
    var messages: [Message] = []
    
    func save(callback: (NSError?) -> Void) {
        
        let fragments = textView.getFragments()
        var requests = 0
        
        for frag in fragments {
            
            // We can just add a text fragment straight into the array
            if let text = frag as? String {
                let msg = TextMessage()
                msg.text = text
                messages.append(msg)
            }
            
            // Handle an image fragment upload
            if let img = frag as? NSData {
                messages.append(ImageMessage())
                let index = messages.endIndex-1
                requests++
                
                Imgur.upload(img) { result, error in
                    requests--
                    
                    if result != nil {
                        let msg = self.messages[index] as! ImageMessage
                        msg.type = (result!.type == "image/gif") ? .GIF : .Image
                        msg.src = result?.url
                        msg.width = result?.width
                        msg.height = result?.height
                    }
                    
                    if requests == 0 {
                        self.saveMessage { error in
                            callback(error)
                        }
                    }
                }

            }
            
        }
        
        if requests == 0 {
            saveMessage { error in
                callback(error)
            }
        }
        
    }
    
    
    func saveMessage(callback: (NSError?) -> Void) {
        
        Peach.createPost(messages) { error in
            if error != nil {
                callback(error)
            } else {
                self.view.window?.close()
            }
        }
        
    }
    
    // MARK: - Moving buttons
    
    override func viewDidLayout() {
        super.viewDidLayout()
        moveButtons()
    }
    
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
