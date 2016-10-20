//
//  LocationController.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import CoreLocation
import Foundation


let LocationManagerDidUpdateLocationNotification = "LocationManagerDidUpdateLocationNotification"
let LocationManagerDidUpdateHeadingNotification = "LocationManagerDidUpdateHeadingNotification"

let kDidAskToTurnOnLocation = "kDidAskToTurnOnLocation"

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationManager()
    
    private override init() {
        super.init()
    }
    
    // MARK: Properties
    
    private(set) var location: CLLocation?
    private(set) var locationManager: CLLocationManager!
    private(set) var simulationMode: Bool = false
    private(set) var heading: CLHeading?
    var locationChangedDistanceToNotify: CLLocationDistance = 50
    
    static var didAskToTurnOnLocation: Bool? {
        get {
            if let value = (BeastNOSQL.object(key: kDidAskToTurnOnLocation) as AnyObject).boolValue {
                return value
            }
            return false
        }
        set(value) {
            BeastNOSQL.setObject(value: value, key: kDidAskToTurnOnLocation)
        }
    }
    
    // MARK: Class functions
    
    static func requestLocationPermission() {
        
        if (CLLocationManager.authorizationStatus() == .denied && LocationManager.didAskToTurnOnLocation != nil) {
            
//            let alert = UIAlertView(title: nil, message: NSLocalizedString("Please enable device Location Services", comment: ""), delegate: nil, cancelButtonTitle: nil)
//            alert.addButtonItem(RIButtonItem.itemWithLabel(NSLocalizedString("Cancel", comment: "")) as! RIButtonItem)
//            alert.addButtonItem(RIButtonItem.itemWithLabel(NSLocalizedString("Open Settings", comment: ""), action: { () -> Void in
//                ActionsManager.sharedInstance.openSettings()
//            }) as! RIButtonItem)
//            
//            alert.show();
            
            LocationManager.didAskToTurnOnLocation = true
        }
        
        LocationManager.sharedInstance.startUpdatingLocation()
    }
    
    static func isAuthorized() -> Bool {
        
        let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .restricted {
            return false
        }
        return true
    }
    
    
    // MARK: Actions
    
    func startUpdatingLocation() {
        
        if self.locationManager == nil {
            
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = kCLDistanceFilterNone

            self.locationManager.requestWhenInUseAuthorization()
        }
        
        self.locationManager.startUpdatingLocation()
        
        if !CLLocationManager.locationServicesEnabled() {
            
            print("location services disabled")
            
            self.stopUpdatingLocation()
        }
    }
    
    func stopUpdatingLocation() {
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingHeading() {
        
        self.locationManager.startUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        
        self.locationManager.stopUpdatingHeading()
    }
    
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if LocationManager.isAuthorized() {
            self.startUpdatingLocation()
        }
        else {
            self.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let newLocation = locations.last {
            if self.location != nil {
                let distanceDifference = self.location!.distance(from: newLocation)
                if distanceDifference < locationChangedDistanceToNotify {
                    return
                }
            }
            
            self.location = newLocation
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocationManagerDidUpdateLocationNotification), object: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {

        heading = newHeading
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocationManagerDidUpdateHeadingNotification), object: nil)
    }
}
