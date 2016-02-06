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
    
    
    
    @IBAction func clickMagicButton(sender: AnyObject) {
        let components = magicButton.title.componentsSeparatedByString(":")
        
        if let type = components.first {
            if requiresInput.contains(type) {
                magicInputController?.view.hidden = false
            } else {
                addSimpleAttachmentFromType(type)
            }
        }
        
    }
    
    /**
     Add a 'simple' attachement to the textview. That is one that doesn't require input.
     
     - parameter type: The type of attachment to add
     */
    func addSimpleAttachmentFromType(type: String) {
        var attachmentString: NSAttributedString {
            switch type {
            case "date":
                return DateAttachment(textView: textView).attributedString
            case "time":
                return TimeAttachment(textView: textView).attributedString
            case "goodnight":
                return GoodNightAttachment(textView: textView).attributedString
            case "goodmorning":
                return GoodMorningAttachment(textView: textView).attributedString
            case "dice":
                return DiceAttachment(textView: textView).attributedString
            case "battery":
                return BatteryAttachment(textView: textView).attributedString
            case "rate":
                return RatingAttachment(textView: textView).attributedString
            case "mood":
                return MoodAttachment(textView: textView).attributedString
            default:
                return NSAttributedString(string: "")
            }
        }
        
        textView.textStorage?.setAttributedString(textView.attributedString().attributedStringByRemovingLastWord())
        textView.textStorage?.appendAttributedString(attachmentString)
        textView.textStorage?.appendAttributedString(NSAttributedString(string: "\n\n"))
    }
    
    /**
     Generate an options attachment from an array of strings
     
     - parameter options: Array of string options
     
     - returns: A `PeachTextOptionsAttachment` wrapped in an attributed string
     */
    func optionsAttachmentFromOptions(options: [String]) -> NSAttributedString {
        let attachment = PeachTextOptionsAttachment(options: options, textView: textView)
        return NSAttributedString(attachment: attachment)
    }
    
    
}
