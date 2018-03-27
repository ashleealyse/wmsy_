//
//  MapVC.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import SVProgressHUD

class MapVC: UIViewController {

//    var mapView = MapView()
//
//    var locationManager = CLLocationManager()
//
//    var feedWhims: [Whim] = [] {
//        didSet {
//            print("MapVC feedWhims: \(feedWhims)")
//            delegate?.changeListOf(whims: feedWhims)
//        }
//    }
//    weak var delegate: setFiltersVCDelegate?
//    weak var delegate: ParentDelegate?
    
    
    // sends map updates to the parent vc - FeedMapVC
//    var userLocation = CLLocation(){
//        didSet{
//            print("MapVC userLocation set")
//            DBService.manager.getClosestWhims(location: userLocation) { (whims) in
//                self.feedWhims = whims
////                self.delegate?.updateChildren(whims: whims)
//            }
//        }
//    }
    
    // takes in Whims, updates local whim array
//   public func update(withWhims: [Whim]) {
//        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
//            self.feedWhims = whims
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        SVProgressHUD.dismiss()
//        view.addSubview(mapView)
//
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
//        self.locationManager.delegate = self
//
//        let mylocation = mapView.mapView.myLocation
//        mapView.mapView.camera = GMSCameraPosition.camera(withLatitude: (mylocation?.coordinate.latitude)!,
//                                                          longitude: (mylocation?.coordinate.longitude)!,
//                                                          zoom: mapView.zoomLevel)
//        mapView.mapView.settings.myLocationButton = true
//        mapView.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}


//extension MapVC: CLLocationManagerDelegate{
//
//
//    // Handle incoming location events.
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation = locations.last!
//        print("Location: \(location)")
//        self.userLocation = location
//
//    }
//
//    // Handle authorization for the location manager.
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .restricted:
//            print("Location access was restricted.")
//        case .denied:
//            print("User denied access to location.")
//        case .notDetermined:
//            print("Location status not determined.")
//        case .authorizedAlways: fallthrough
//        case .authorizedWhenInUse:
//            print("Location status is OK.")
//        }
//    }
//
//    // Handle location manager errors.
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        self.locationManager.stopUpdatingLocation()
//        print("Error: \(error)")
//    }
//}

//extension MapVC: mapDetailViewDelegate {
//    func interestPressed() {
//        print("interest is being pressed")
//    }
//
//    func userPicturePressed() {
//        present(GuestProfileVC(), animated: true, completion: nil)
//    }
//
//
//}

