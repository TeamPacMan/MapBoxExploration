//
//  LocationManager.swift
//  MapBoxTest
//
//  Created by William Wong on 26/06/2017.
//  Copyright © 2017 Fleetmatics. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    // private
    fileprivate let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            currentLocation = lastLocation.coordinate
        }
        locationManager.stopUpdatingLocation()
    }

    deinit {
        locationManager.delegate = nil
    }
}
