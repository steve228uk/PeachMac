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
    
    var imageMessages: [Message] = []
    
    func save() {
        
        let images = textView.getImages()
        var requests = 0
        for img in images {
            requests++
            Imgur.upload(img) { result, error in
                requests--
                
                if result != nil {
                    let msg = ImageMessage()
                    msg.src = result?.url
                    msg.width = result?.width
                    msg.height = result?.height
                    self.imageMessages.append(msg)
                }
                
                if requests == 0 {
                    self.saveMessage()
                }
            }
        }
        
    }
    
    func saveMessage() {
        
        Peach.createPost(imageMessages) { error in
        }
        
        view.window?.close()
        
    }
    
}
