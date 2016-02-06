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

class WeatherAttachmentHandler: DeferredAttachmentHandler, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    override func handle() {
        print("handled")
        
        let status = CLLocationManager.authorizationStatus()
        let enabled = CLLocationManager.locationServicesEnabled()
        
        if status != .Denied && status != .Restricted && enabled {
            print("not restricted")
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager?.distanceFilter = 500
            locationManager?.startUpdatingLocation()
        }
    }
    
    // MARK: - Core Location
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        print(newLocation)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        manager.stopUpdatingLocation()
        
        print(locations)
        
        let coordinates: CLLocationCoordinate2D = manager.location!.coordinate
        
        let params = [
            "lat": "\(coordinates.latitude)",
            "lon": "\(coordinates.longitude)",
            "APPID": "a775ef77a0748604c315672eff912c5a"
        ]
        
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather", parameters: params)
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    if let weather = json["weather"].array {
                        if let description = weather[0]["main"].string {
                            print(description)
                            let attachment = PeachTextAttachment(string: "\(description)", textView: self.textView)
                            self.delegate?.appendDeferredAttachment(attachment)
                        }
                    }
                }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print(status)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
}