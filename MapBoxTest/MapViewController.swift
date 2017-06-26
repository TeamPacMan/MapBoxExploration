//
//  MapViewController.swift
//  MapBoxTest
//
//  Created by William Wong on 23/06/2017.
//  Copyright © 2017 Fleetmatics. All rights reserved.
//

import Foundation
import Mapbox
import MapboxDirections
import MapboxNavigation

protocol Navigatable {
    func navigation(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D)
}

class MapViewController: UIViewController, Navigatable {
    var mapView:MGLMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView(view.bounds)
    }

    func setUpMapView(_ frame: CGRect) {
        mapView = MGLMapView(frame: frame)
        mapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Set the delegate property of our map view to `self` after instantiating it.
        mapView?.delegate = self
        if let mapView = mapView {
            view.addSubview(mapView)
        }
    }

    func navigation(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let start = Waypoint(coordinate: origin)
        let end = Waypoint(coordinate: destination)

        let options = RouteOptions(waypoints: [start, end], profileIdentifier: .automobileAvoidingTraffic)
        options.routeShapeResolution = .full
        options.includesSteps = true

        _ = Directions.shared.calculate(options) { (waypoints, routes, error) in
            guard let route = routes?.first else { return }

            let viewController = NavigationViewController(for: route)
            self.present(viewController, animated: true, completion: nil)
        }

    }
}

extension MapViewController: MGLMapViewDelegate {
    
    // Use the default marker. See also: our view annotation or custom marker examples.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }

    // Allow callout view to appear when an annotation is tapped.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}
