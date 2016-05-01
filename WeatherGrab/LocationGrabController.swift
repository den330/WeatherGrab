//
//  LocationGrabController.swift
//  WeatherGrab
//
//  Created by Yaxin Yuan on 16/5/1.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import CoreLocation
import Foundation

class LocationGrabController: NSObject, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    
    
    func getLocation(){
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .NotDetermined{
            locationManager.requestWhenInUseAuthorization()
            return
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("sth wrong \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdate \(newLocation)")
    }
    
}
