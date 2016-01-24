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

class ComposeViewController: PeachViewController {
    
    @IBOutlet var textView: PeachComposeTextView!
    
    var messages: [Message] = []
    
    func save() {
        
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
                        msg.src = result?.url
                        msg.width = result?.width
                        msg.height = result?.height
                    }
                    
                    if requests == 0 {
                        self.saveMessage()
                    }
                }

            }
            
            
        }
        
    }
    
    
    func saveMessage() {
        
        Peach.createPost(messages) { error in
//             TODO: Handle any error that comes back from Peach
        }
        
        view.window?.close()
        
    }
    
}
