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
    
    @IBOutlet weak var magicButton: MagicButton!
    
    /// The controller that we can interact with to create some magic input ✨
    var magicInputController: MagicInputViewController?
    
    /// These are the message fragments that will be posted to Peach
    var messages: [Message] = []
    
    /// The location manager for fetching the current location
    let locationManager = LocationManager()
    
    let magicWords = [
        "gif": "Search for a GIF",
//        "image": "Search for images",
        "time": "Add current time",
        "weather": "Add current weather",
        "goodnight": "Good night!",
        "goodmorning": "Good morning!",
//        "here": "Add current location",
        "mood": "How are you feeling?",
        "rate": "Rate something 1-5 stars",
        "battery": "Current charge %",
        "dice": "Roll the dice",
        "date": "Add the current date",
        "movie": "Add movie",
        "tv": "Add TV show",
        "game": "Add video game",
//        "book": "Add book",
//        "events": "# of events today",
        "song": "What's currently playing",
//        "draw": "Draw something",
//        "shout": "Say something with big words"
    ]
    
    /// These are magic words that require input from the user
    let requiresInput = ["gif", "image", "movie", "tv", "game", "book"]
    
    /// These are magic words that access async services
    let deferred = ["goodmorning", "weather"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textStorage?.delegate = self
    }
    
    deinit {
        textView.textStorage?.setAttributedString(NSAttributedString(string: ""))
        textView = nil
    }
    
    
    // MARK: - Save Action
    
    /**
    Process the fragments, upload any images etc.
    
    - parameter callback: Callback with optional `NSError`
    */
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
            
            // If this is a dictionary then we can do a few things
            if let dict = frag as? [String:String] {
                if let track = dict["track"] {
                    let msg = MusicMessage()
                    msg.title = track
                    messages.append(msg)
                }
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
    
    
    /**
     Send the message to Peach
     
     - parameter callback: Callback with optional `NSError`
     */
    func saveMessage(callback: (NSError?) -> Void) {
        
        Peach.createPost(messages) { error in
            if error != nil {
                callback(error)
            } else {
                self.view.window?.close()
            }
        }
        
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedInput" {
            magicInputController = segue.destinationController as? MagicInputViewController
            magicInputController?.view.hidden = true
        }
    }
    
    
}
