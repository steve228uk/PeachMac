//
//  GoodmorningAttachmentHandler.swift
//  Peach
//
//  Created by Stephen Radford on 08/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa

class GoodmorningAttachmentHandler: DeferredAttachmentHandler, LocationManagerDelegate {
    
    init(textView: NSTextView, locationManager: LocationManager) {
        super.init(textView: textView)
        
        if let location = locationManager.location {
            Weather.weatherFromLatLon(location.lat, lon: location.lon, callback: createAttachment)
        } else {
            locationManager.delegate = self
            locationManager.getLocation()
        }
        
    }
    
    func locationUpdated(lat: Double, lon: Double) {
        Weather.weatherFromLatLon(lat, lon: lon, callback: createAttachment)
    }
    
    func createAttachment(string: String){
        let attachment = GoodmorningAttachment(weather: string, textView: self.textView)
        self.delegate?.appendDeferredAttachment(attachment)
    }
    
}