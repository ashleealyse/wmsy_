//
//  MapView.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit
import MapKit

extension GMSCameraUpdate {
    
    static func fit(coordinate: CLLocationCoordinate2D, radius: Double) -> GMSCameraUpdate {
        var leftCoordinate = coordinate
        var rigthCoordinate = coordinate
        let radius = radius * 1609.34 // convert miles to meters
        
        let region = MKCoordinateRegionMakeWithDistance(coordinate, radius, radius)
        let span = region.span
        
        leftCoordinate.latitude = coordinate.latitude - span.latitudeDelta
        leftCoordinate.longitude = coordinate.longitude - span.longitudeDelta
        rigthCoordinate.latitude = coordinate.latitude + span.latitudeDelta
        rigthCoordinate.longitude = coordinate.longitude + span.longitudeDelta
        
        let bounds = GMSCoordinateBounds(coordinate: leftCoordinate, coordinate: rigthCoordinate)
        let update = GMSCameraUpdate.fit(bounds, withPadding: -15.0)
        
        return update
    }
}

class MapView: UIView {
    
    let googleMap = GMSMapView()
    var currentLocation: CLLocation?
    var range: Int = 25 // miles to zoom map out
    
    convenience init(location: CLLocation, range: Int) {
        self.init()
        self.currentLocation = location
        self.range = range
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        self.addSubviews()
        self.customizeSubviews()
        self.constrainSubviews()
    }
    private func addSubviews() {
        self.addSubview(googleMap)
    }
    private func customizeSubviews() {
        self.customizeGoogleMap()
    }
    private func constrainSubviews() {
        self.constrainGoogleMap()
    }
    
    //MARK: - GoogleMap
    private func customizeGoogleMap() {
        if let currentLocation = currentLocation {
            let coordinate: CLLocationCoordinate2D = currentLocation.coordinate
            let update = GMSCameraUpdate.fit(coordinate: coordinate, radius: Double(range))
            googleMap.moveCamera(update)
            googleMap.isMyLocationEnabled = true
        }
    }
    private func constrainGoogleMap() {
        googleMap.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: - API
    public func updateCameraTo(location: CLLocation?, range: Int ) {
        self.currentLocation = location
        self.range = range
        if let currentLocation = currentLocation {
            let coordinate: CLLocationCoordinate2D = currentLocation.coordinate
            let update = GMSCameraUpdate.fit(coordinate: coordinate, radius: Double(range))
            googleMap.moveCamera(update)
        }
    }
    public func showUserLocationAndLocationButton(_ show: Bool) {
        googleMap.isMyLocationEnabled = show
        googleMap.settings.myLocationButton = show
    }
}

class MapViewOld: UIView {
    
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    var detailView = MapDetailView()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        loadView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.consumesGesturesInView = false
        // Add the map to the view, hide it until we've got a location update.
        
        
        self.addSubview(mapView)

        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        mapView.addSubview(detailView)
//        detailView.layer.cornerRadius = 20
        detailView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing).offset(-11)
            make.leading.equalTo(self.snp.leading).offset(11)
            make.bottom.equalTo(self.snp.bottom).offset(-11)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(self.snp.height).multipliedBy(0.25)
        }
        
    }

}

