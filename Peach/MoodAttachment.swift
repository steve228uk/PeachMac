//
//  MoodAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class MoodAttachment: PeachTextOptionsAttachment {

    init(textView: NSTextView?) {
        
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
        
        super.init(options: options, textView: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
