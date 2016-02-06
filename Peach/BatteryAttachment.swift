//
//  BatteryAttachment.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import IOKit.ps

class BatteryAttachment: PeachTextAttachment {

    init(textView: NSTextView?) {
        
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
        
        super.init(string: string!, textView: textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
