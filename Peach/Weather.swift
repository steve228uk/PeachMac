//
//  Weather.swift
//  Peach
//
//  Created by Stephen Radford on 08/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Weather {
    
    /**
     Get the weather from OpenWeatherMapAPI
     
     - parameter lat: Latitude
     - parameter lon: Longitude
     */
    class func weatherFromLatLon(lat: Double, lon: Double, callback: (String) -> Void) {
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
                    if let main = json["main"].dictionary, weather = json["weather"].array {
                        if let temp = main["temp"]?.float, icon = weather[0]["icon"].string {
                            callback("\(self.emojiForIcon(icon)) \(Int(round(temp)))°C")
                        }
                    }
                }
        }
    }
    
    class func emojiForIcon(icon: String) -> String {
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