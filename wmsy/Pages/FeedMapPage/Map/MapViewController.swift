//
//  MapViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps

protocol MapViewControllerDelegate: class {
    func mapView(_ mapView: MapViewController, didChangeLocation location: CLLocation) -> Void
}

class MapViewController: UIViewController {
    
    var delegate: MapViewControllerDelegate?
    let locationManager = CLLocationManager()
    var mapView = MapView()
    let whimDetailsView = UIView()
    // TODO: have segmented control decide this range
    let desiredRange: Int = 5 // miles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = . blue
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined ,.restricted, .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        }
        
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined ,.restricted, .denied:
            self.mapView.showUserLocationAndLocationButton(false)
        case .authorizedAlways, .authorizedWhenInUse:
            self.mapView.showUserLocationAndLocationButton(true)
            manager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else { return }
        self.mapView.updateCameraTo(location: mostRecentLocation, range: self.desiredRange)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print()
    }
}

