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
    private var lat:Double = 0
    private var lgn:Double = 0
    
    static let shareInstace:LocationManager = {
        let instance = LocationManager()
        instance.locationManager = CLLocationManager()
        instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        instance.locationManager.requestAlwaysAuthorization()

        Timer.scheduledTimer(timeInterval: 300, target: instance, selector:  #selector(instance.startLoadLocation), userInfo: nil, repeats: true)

        return instance
    }()

    
    func getLatitude() -> Double  {
        return lat
    }
    
    func getLongitude() -> Double  {
        return lgn
    }
    
    
    func startLoadLocation(){
    
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        locationManager.stopUpdatingLocation()
        lat = userLocation.coordinate.latitude
        lgn = userLocation.coordinate.longitude
        
        let user = User()
        user.lat = String(lat)
        user.lgn = String(lgn)
        user.userId = UserDefaults.standard.object(forKey: USER_ID) as! String!
        user.username = UserDefaults.standard.object(forKey: USER_NAME) as! String!
        user.photoURL = UserDefaults.standard.object(forKey: USER_PHOTO_URL) as! String!
        
        let updateAt:TimeInterval = Date().timeIntervalSince1970
        user.updateAt = String(updateAt)
        
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
