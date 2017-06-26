//
//  MapGeocoderBL.swift
//  MapBoxTest
//
//  Created by William Wong on 23/06/2017.
//  Copyright © 2017 Fleetmatics. All rights reserved.
//

import Foundation
import MapboxGeocoder
#if !os(tvOS)
    import Contacts
#endif

struct MapGeocoderBL {

    let geocoder = Geocoder.shared

    func forwardGeocoding(address: String, completion: @escaping (CLLocationCoordinate2D)->() ) {

        let options = ForwardGeocodeOptions(query: address)

//        // To refine the search, you can set various properties on the options object.
//        options.allowedISOCountryCodes = ["IRE"]
//        options.focalLocation = CLLocation(latitude: 53.298199, longitude: -6.373076)
//        options.allowedScopes = [.address, .pointOfInterest]

        let _ = geocoder.geocode(options) { (placemarks, attribution, error) in
            guard let placemark = placemarks?.first else {
                return
            }

            print(placemark.name)
            // 200 Queen St
            print(placemark.qualifiedName)
            // 200 Queen St, Saint John, New Brunswick E2L 2X1, Canada

            let coordinate = placemark.location.coordinate
            print("\(coordinate.latitude), \(coordinate.longitude)")
            completion(coordinate)
            // 45.270093, -66.050985

            #if !os(tvOS)
                let formatter = CNPostalAddressFormatter()
                print(formatter.string(from: placemark.postalAddress!))
                // 200 Queen St
                // Saint John New Brunswick E2L 2X1
                // Canada
            #endif
        }
    }
}
