//
//  ComposeViewController+NSTextViewDelegate.swift
//  Peach
//
//  Created by Stephen Radford on 31/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

extension ComposeViewController: NSTextStorageDelegate {
    
    // MARK: - Magic Words ✨
    
    override func textStorageDidProcessEditing(notification: NSNotification) {
        
        magicButton.hidden = true
        magicButton.enabled = true
        magicInputController?.view.hidden = true
        
        if let text = textView.textStorage?.string.lowercaseString {

            let lines = text.componentsSeparatedByString("\n")
            if let words = lines.last?.componentsSeparatedByString(" ") {
            
                if let last = words.last {
                    
                    var magicWord: String?
                    
                    // Loop through the patterns and match them against the word
                    for (pattern, _) in magicWords {
                        if let match = pattern.rangeOfString(last) {
                            if let first = match.first {
                                if first == pattern.startIndex {
                                    magicWord = pattern
                                    break
                                }
                            }
                        }
                    }
                    
                    if let word = magicWord {
                        showMagicButtonForWord(word)
                    } else {
                        magicButton.hidden = true
                    }
                    
                }
                
            }
            
        }
        
    }
    
    /**
     Show the magic word button for the magic word matched
     
     - parameter word: The word that was matched
     */
    func showMagicButtonForWord(word: String) {
        
        if let label = magicWords[word] {
            let para = NSMutableParagraphStyle()
            para.alignment = .Center
            let attributes = [
                NSFontAttributeName: NSFont.systemFontOfSize(13, weight: NSFontWeightMedium),
                NSForegroundColorAttributeName: NSColor(hue:0, saturation:0, brightness:0.45, alpha:1),
                NSParagraphStyleAttributeName: para
            ]
            
            let attributedTitle = NSAttributedString(string: "\(word): \(label)", attributes: attributes)
            
            magicButton.attributedTitle = attributedTitle
            magicButton.hidden = false
        }
        
    }
    
    /**
     Controls what to do when the magic button is clicked. Should a simple attachement be added or is input required?
     
     - parameter sender: The magic button
     */
    @IBAction func clickMagicButton(sender: NSButton) {
        let components = magicButton.title.componentsSeparatedByString(":")
        
        if let type = components.first {
            if requiresInput.contains(type) {
                sender.hidden = true
                magicInputController?.textField.placeholderString = magicWords[type]
                magicInputController?.textField.stringValue = ""
                magicInputController?.view.hidden = false
                magicInputController?.textField.becomeFirstResponder()
                handleAttachmentWithInputForType(type)
            } else if deferred.contains(type) {
                sender.enabled = false
                sender.title = "Working..."
                handleDeferredAttachmentForType(type)
            } else {
                addSimpleAttachmentForType(type)
            }
        }
        
    }
    
    func handleDeferredAttachmentForType(type: String) {
        switch type {
        case "weather":
            let handler = WeatherAttachmentHandler(textView: textView, locationManager: locationManager)
            handler.delegate = self
            break
        case "goodmorning":
            let handler = GoodmorningAttachmentHandler(textView: textView, locationManager: locationManager)
            handler.delegate = self
            break
        default:
            break
        }
    }
    
    /**
     Handle the attachment with input by hooking up the search of the magic input view.
     
     - parameter type: The type of attachement to handle
     */
    func handleAttachmentWithInputForType(type: String) {
        
        var handler: MagicInputHandler? {
            switch type {
            case "gif":
                let handler = GIFSearch(textView: textView)
                handler.delegate = self
                return handler
            case "game":
                let handler = GameSearch(textView: textView)
                handler.delegate = self
                return handler
            default:
                return nil
            }
        }
        
        magicInputController?.delegate = handler
    }
    
    /**
     Add a 'simple' attachement to the textview. That is one that doesn't require input.
     
     - parameter type: The type of attachment to add
     */
    func addSimpleAttachmentForType(type: String) {
        var attachmentString: NSAttributedString {
            switch type {
            case "date":
                return DateAttachment(textView: textView).attributedString
            case "time":
                return TimeAttachment(textView: textView).attributedString
            case "goodnight":
                return GoodNightAttachment(textView: textView).attributedString
            case "dice":
                return DiceAttachment(textView: textView).attributedString
            case "battery":
                return BatteryAttachment(textView: textView).attributedString
            case "rate":
                return RatingAttachment(textView: textView).attributedString
            case "mood":
                return MoodAttachment(textView: textView).attributedString
            case "song":
                return SongAttachment(textView: textView).attributedString
            default:
                return NSAttributedString(string: "")
            }
        }
        
        textView.textStorage?.setAttributedString(textView.attributedString().attributedStringByRemovingLastWord())
        textView.textStorage?.appendAttributedString(attachmentString)
        textView.textStorage?.appendAttributedString(NSAttributedString(string: "\n\n"))
    }
    
    
}
