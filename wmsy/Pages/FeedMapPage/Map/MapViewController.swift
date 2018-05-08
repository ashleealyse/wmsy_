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
    var currentLocation: CLLocation?
    
    var markers: [Whim: GMSMarker] = [:]
    var whimsSet = Set<Whim>()
    var selectedWhim: Whim? {
        didSet {
            guard let whim = selectedWhim,
                let marker = markers[whim]
                else {
                self.mapView.updateCameraTo(location: currentLocation, range: desiredRange)
                return
            }
            let camera = GMSCameraPosition.camera(withLatitude: marker.position.latitude,
                                                  longitude: marker.position.longitude,
                                                  zoom: 17.0)
            self.mapView.googleMap.animate(to: camera)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = . blue
        
        mapView.googleMap.delegate = self
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
            self.mapView.showUserLocationAndLocationButton(true)
        }
        
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }
    
    
    
    // MARK: - Receiving data
    public func updateWhimsTo(_ whims: [Whim]) {
        let whims = Set(whims)
        let addingWhims = whims.subtracting(self.whimsSet)
        let removingWhims = self.whimsSet.subtracting(whims)
        
        addingWhims.forEach{
            addMarkerFor($0)
            self.whimsSet.insert($0)
        }
        removingWhims.forEach{
            removeMarkerFor($0)
            self.whimsSet.remove($0)
        }
    }
    private func addMarkerFor(_ whim: Whim) {
        DispatchQueue.main.async {
            let position = CLLocationCoordinate2D(latitude: Double(whim.lat)!, longitude: Double(whim.long)!)
            let marker = GMSMarker(position: position)
            marker.userData = ["whim": whim]
            marker.icon = GMSMarker.markerImage(with: Stylesheet.Colors.WMSYDeepViolet)
            marker.map = self.mapView.googleMap
            self.markers[whim] = marker
        }
    }
    private func removeMarkerFor(_ whim: Whim) {
        DispatchQueue.main.async {
            guard let marker = self.markers[whim] else { return }
            marker.map = nil
            self.markers.removeValue(forKey: whim)
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
        self.currentLocation = mostRecentLocation
        self.mapView.updateCameraTo(location: mostRecentLocation, range: self.desiredRange)
        self.delegate?.mapView(self, didChangeLocation: mostRecentLocation)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let dict = marker.userData as? [String: Any],
            let whim = dict["whim"] as? Whim
            else {
                print("doesn't work this way")
            return false
        }
        self.selectedWhim = whim
        return true
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.selectedWhim = nil
    }
}
