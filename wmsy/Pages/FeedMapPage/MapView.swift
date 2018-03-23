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

class MapView: UIView {
    
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    
    
    
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

        // Add the map to the view, hide it until we've got a location update.
        
        
        self.addSubview(mapView)
        
        
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
    }

}

