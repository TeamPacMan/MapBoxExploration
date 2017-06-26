//
//  ViewController.swift
//  MapBoxTest
//
//  Created by William Wong on 16/05/2017.
//  Copyright © 2017 Fleetmatics. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?

    var delegate: Navigatable?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    deinit {
        locationManager.stopUpdatingLocation()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? Navigatable {
            delegate = controller
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text, let current = currentLocation {
            let geocoder = MapGeocoderBL()
            geocoder.forwardGeocoding(address: searchString) {[weak self] (result) in
                self?.delegate?.navigation(origin: current, destination: result)
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location?.coordinate
    }
}

