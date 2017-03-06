//
//  LocationManager.swift
//  Up+
//
//  Created by Nguyen Manh Tuan on 2/27/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject,CLLocationManagerDelegate {

    var locationManager:CLLocationManager!
    
    static let shareInstace:LocationManager = {
        let instance = LocationManager()
        instance.locationManager = CLLocationManager()
        
        instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        instance.locationManager.requestAlwaysAuthorization()
        return instance
    }()
    

    func startLoadLocation(){
        
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        locationManager.stopUpdatingLocation()
        
        let user = User()
        user.lat = String(userLocation.coordinate.latitude)
        user.lgn = String(userLocation.coordinate.longitude)
        user.userId = UserDefaults.standard.object(forKey: USER_ID) as! String!
        user.username = UserDefaults.standard.object(forKey: USER_NAME) as! String!
        user.photoURL = UserDefaults.standard.object(forKey: USER_PHOTO_URL) as! String!
        
        
        let firManager = FIRUserManager()
        firManager.updateUser(user: user)
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }


    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }
 
}
