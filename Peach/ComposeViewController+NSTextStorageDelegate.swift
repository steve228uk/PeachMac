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
            switch type {
            case "time":
                let date = NSDate()
                let attachment = PeachTextAttachment(string: "\(String(format: "%02d", date.hour())):\(String(format: "%02d", date.minute()))")
                let attributedString = NSAttributedString(attachment: attachment)
                textView.textStorage?.appendAttributedString(attributedString)
                break
            default:
                break
            }
        }
        
    }
    
    
}
