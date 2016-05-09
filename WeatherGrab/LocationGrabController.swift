//
//  LocationGrabController.swift
//  WeatherGrab
//
//  Created by Yaxin Yuan on 16/5/1.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//

import CoreLocation
import Foundation


protocol cityDelegate {
    func showCity(city: String?)
}


class LocationGrabController: NSObject, CLLocationManagerDelegate{
    
    var delegate: cityDelegate?
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var lastLocationError: NSError?
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var lastGeocodingError: NSError?
    var city: String?
    
    func clear(){
        location = nil
        lastGeocodingError = nil
        lastLocationError = nil
        placemark = nil
        city = nil
    }
    
    func startLocationManager(){
        clear()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    
    
    func getLocation(){
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .NotDetermined{
            locationManager.requestWhenInUseAuthorization()
            return
        }
        startLocationManager()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        if error.code == CLError.LocationUnknown.rawValue{
            print("unknown")
            return
        }
        lastLocationError = error
        stopLocationManager()
    }
    
    func stopLocationManager(){
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        
        if location == nil || location!.horizontalAccuracy >= newLocation.horizontalAccuracy{
            lastLocationError = nil
            location = newLocation
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy{
                stopLocationManager()
                geocoder.reverseGeocodeLocation(location!, completionHandler: {
                    placemarks, error in
                    self.lastGeocodingError = error
                    if error == nil, let p = placemarks where !p.isEmpty{
                        self.placemark = p.last!
                        let city = self.stringFromPlacemark(self.placemark!)
                        self.city = city
                        dispatch_async(dispatch_get_main_queue()){
                            self.delegate?.showCity(self.city)
                        }
                    }else{
                        self.placemark = nil
                    }
                })
            }
        }
    }
    
    func stringFromPlacemark(placemark: CLPlacemark) -> String{
        var cityName = ""
        if let s = placemark.locality{
            cityName = s
        }else{
            cityName = "unknown"
        }
        return cityName
    }
}
