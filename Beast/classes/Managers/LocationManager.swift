//
//  LocationController.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import CoreLocation
import Foundation

public let LocationManagerDidUpdateLocationNotification = "LocationManagerDidUpdateLocationNotification"
public let LocationManagerDidUpdateHeadingNotification = "LocationManagerDidUpdateHeadingNotification"

public class LocationManager: NSObject, CLLocationManagerDelegate {
    
    public static let shared = LocationManager()
    private(set) var manager: CLLocationManager!
    
    private override init() {
        super.init()
        
        self.manager = CLLocationManager()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.manager.distanceFilter = 5
    }
    
    
    // MARK: Properties
    
    public var location: CLLocation?
    private(set) var heading: CLHeading?
    
    
    // MARK: Actions
    
    public func startUpdatingLocation() {
        
        if !CLLocationManager.locationServicesEnabled()
        || !isAuthorized() {
            requestAutorization()
            print("location services disabled")
            return
        }
        manager.startUpdatingLocation()
    }
    
    public func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }

    
    // MARK: Class functions
    
    public func showManualAutorizationAlert() {
        
        let alert = UIAlertView(title: nil, message: NSLocalizedString("Please enable device Location Services", comment: ""), delegate: nil, cancelButtonTitle: nil)
        
        alert.addButtonItem(RIButtonItem.itemWithLabel(NSLocalizedString("Cancel", comment: "")) as! RIButtonItem)
        
        alert.addButtonItem(RIButtonItem.itemWithLabel(NSLocalizedString("Open Settings", comment: ""), action: { () -> Void in
            ActionsManager.sharedInstance.openSettings()
        }) as! RIButtonItem)
        
        alert.show()
    }
    
    public func isAuthorized() -> Bool {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways: return true
        case .authorizedWhenInUse: return true
        case .denied: break
        case .notDetermined: break
        case .restricted: break
        }
        return false
    }
    
    public func requestAutorization() {
    
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways: break
        case .authorizedWhenInUse: break
        case .denied:
            showManualAutorizationAlert()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            showManualAutorizationAlert()
        }
    }

    
    // MARK: CLLocationManagerDelegate , update location information
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if !isAuthorized() {
            stopUpdatingLocation()
            return
        }
        startUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = manager.location
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocationManagerDidUpdateLocationNotification), object: nil)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    // MARK: - update heading information
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {

        heading = newHeading
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocationManagerDidUpdateHeadingNotification), object: nil)
    }
    
    public func startUpdatingHeading() {
        manager.startUpdatingHeading()
    }
    
    public func stopUpdatingHeading() {
        manager.stopUpdatingHeading()
    }
}
