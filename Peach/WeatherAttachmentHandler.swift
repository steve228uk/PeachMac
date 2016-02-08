//
//  WeatherAttachmentHandler.swift
//  Peach
//
//  Created by Stephen Radford on 06/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherAttachmentHandler: DeferredAttachmentHandler, LocationManagerDelegate {
    
    init(textView: NSTextView, locationManager: LocationManager) {
        super.init(textView: textView)
        
        if let location = locationManager.location {
            weatherFromLatLon(location.lat, lon: location.lon)
        } else {
            locationManager.delegate = self
            locationManager.getLocation()
        }
        
    }
    
    func locationUpdated(lat: Double, lon: Double) {
        weatherFromLatLon(lat, lon: lon)
    }
    
    /**
     Get the weather from OpenWeatherMapAPI
     
     - parameter lat: Latitude
     - parameter lon: Longitude
     */
    func weatherFromLatLon(lat: Double, lon: Double) {
        let params = [
            "lat": "\(lat)",
            "lon": "\(lon)",
            "units": "metric",
            "APPID": "a775ef77a0748604c315672eff912c5a"
        ]
        
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather", parameters: params)
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    if let main = json["main"].dictionary {
                        if let temp = main["temp"]?.float {
                            if let weather = json["weather"].array {
                                if let icon = weather[0]["icon"].string {
                                    let attachment = PeachTextAttachment(string: "\(self.emojiForIcon(icon)) \(Int(round(temp)))°C", textView: self.textView)
                                    self.delegate?.appendDeferredAttachment(attachment)
                                }
                            }
                        }
                    }
                }
        }
    }
    
    func emojiForIcon(icon: String) -> String {
        switch icon {
        case "11d":
            return "⛈"
        case "09d":
            return "🌧"
        case "10d":
            return "☔️"
        case "13d":
            return "❄️🌨"
        case "50d":
            return "🌫"
        case "01d":
            return "☀️"
        case "02d":
            return "🌤"
        case "03d":
            return "🌥"
        case "04d":
            return "☁️"
            
        case "01n":
            return "✨"
        case "02n", "03n", "04n":
            return "🌙☁️"
        case "09n":
            return "🌙🌧"
        case "10n":
            return "🌙☔️"
        case "11n":
            return "🌙⛈"
        case "13n":
            return "🌙❄️"
            
        default:
            return ""
        }
    }
    
}