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
    var locationManager: LocationManager?
    var delegate: Navigatable?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = LocationManager()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? Navigatable {
            delegate = controller
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text, let current = locationManager?.currentLocation {
            let geocoder = MapGeocoderBL()
            geocoder.forwardGeocoding(address: searchString) {[weak self] (result) in
                self?.delegate?.navigation(origin: current, destination: result)
            }
        }
    }
}
