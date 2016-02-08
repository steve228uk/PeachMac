//
//  LocationManager.swift
//  Peach
//
//  Created by Stephen Radford on 08/02/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Cocoa
import CoreLocation

protocol LocationManagerDelegate {
    
    func locationUpdated(lat: Double, lon: Double)
    
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager?
    
    var delegate: LocationManagerDelegate?
    
    /// The location in lat/lon if available
    var location: (lat: Double, lon: Double)? {
        get {
            if let location = locationManager?.location {
                let coordinates: CLLocationCoordinate2D = location.coordinate
                return (lat: coordinates.latitude, lon: coordinates.longitude)
            }
            return nil
        }
    }
    
    override init() {
       super.init()
        
        let status = CLLocationManager.authorizationStatus()
        let enabled = CLLocationManager.locationServicesEnabled()
        
        if status != .Denied && status != .Restricted && enabled {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager?.distanceFilter = 500
        }
        
    }
    
    // MARK: - Core Location
    
    /**
    Get the location of the user
    */
    func getLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        manager.stopUpdatingLocation()
        let coordinates: CLLocationCoordinate2D = manager.location!.coordinate
        delegate?.locationUpdated(coordinates.latitude, lon: coordinates.longitude)
    }
    
}