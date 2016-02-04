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
            
            var attachmentString: NSAttributedString {
                switch type {
                case "date":
                    let date = NSDate()
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, d MMM YYYY")
                    let dateString = dateFormatter.stringFromDate(date)
                    let attachment = PeachTextAttachment(string: "📰 \(dateString)", textView: textView)
                    return NSAttributedString(attachment: attachment)
                case "time":
                    let date = NSDate()
                    let string = "🕑 \(String(format: "%02d", date.hour())):\(String(format: "%02d", date.minute()))"
                    let attachment = PeachTextAttachment(string: string, textView: textView)
                    return NSAttributedString(attachment: attachment)
                case "goodnight":
                    let date = NSDate()
                    let string = "Good night. 😴\n\n\(String(format: "%02d", date.hour())):\(String(format: "%02d", date.minute()))"
                    let attachment = PeachTextAttachment(string: string, textView: textView)
                    return NSAttributedString(attachment: attachment)
                case "goodmorning":
                    let date = NSDate()
                    let string = "Good morning! 🌤\n\n\(String(format: "%02d", date.hour())):\(String(format: "%02d", date.minute()))"
                    let attachment = PeachTextAttachment(string: string, textView: textView)
                    return NSAttributedString(attachment: attachment)
                case "dice":
                    let string = "🎲 \(Int(arc4random_uniform(6) + 1)) 🎲 \(Int(arc4random_uniform(6) + 1))"
                    let attachment = PeachTextAttachment(string: string, textView: textView)
                    return NSAttributedString(attachment: attachment)
                case "battery":
                    let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
                    let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array
                    var string: String?
                    if sources.count > 0 {
                        let ps = sources[0]
                        let info = IOPSGetPowerSourceDescription(snapshot, ps).takeUnretainedValue() as Dictionary
                        if let capacity = info[kIOPSCurrentCapacityKey] as? Int {
                            string = "🔋 \(capacity)%"
                        }
                    }
                    
                    if string == nil {
                        string = "🔋 100%" // Make it 100% for desktops
                    }
                    
                    let attachment = PeachTextAttachment(string: string!, textView: textView)
                    return NSAttributedString(attachment: attachment)
                case "rate":
                    let options = [
                        "Rating: ⭐️⭐️⭐️⭐️⭐️ 5/5",
                        "Rating: ⭐️ 1/5",
                        "Rating: ⭐️⭐️ 2/5",
                        "Rating: ⭐️⭐️⭐️ 3/5",
                        "Rating: ⭐️⭐️⭐️⭐️ 4/5",
                    ]
                    return optionsAttachmentFromOptions(options)
                case "mood":
                    let options = [
                        "Mood: 😀 happy",
                        "Mood: 😇 blessed",
                        "Mood: 😍 in love",
                        "Mood: 😘 flirty",
                        "Mood: 😂 laughing",
                        "Mood: 😴 tired",
                        "Mood: 😏 sneaky",
                        "Mood: 😢 bored",
                        "Mood: 😷 sick",
                        "Mood: 😢 sad",
                        "Mood: 😭 jealous",
                        "Mood: 😓 stressed",
                        "Mood: 😒 annoyed",
                        "Mood: 😡 angry",
                        "Mood: 💔 heartbroken",
                        "Mood: 🌞 radiant",
                        "Mood: 🐻 hungry",
                        "Mood: 🍀 lucky",
                        "Mood: 🐔 scared",
                        "Mood: 🙅 nope",
                        "Mood: 😈 mischievous",
                        "Mood: 🐑 sheepish",
                        "Mood: 💀 dead"
                    ]
                    return optionsAttachmentFromOptions(options)
                default:
                    return NSAttributedString(string: "")
                }
            }
            
            textView.textStorage?.setAttributedString(textView.attributedString().attributedStringByRemovingLastWord())
            textView.textStorage?.appendAttributedString(attachmentString)
            textView.textStorage?.appendAttributedString(NSAttributedString(string: "\n\n"))
            
        }
        
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
