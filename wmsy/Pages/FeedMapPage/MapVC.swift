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

//protocol ParentDelegate: class {
//    public func updateChildren(whims: [Whim]) -> Void
//}

class MapVC: UIViewController {

    var mapView = MapView()
    
    var locationManager = CLLocationManager()
    
    var feedWhims: [Whim] = []
    
    weak var delegate: ParentDelegate?
    
    
    // sends map updates to the parent vc - FeedMapVC
    var userLocation = CLLocation(){
        didSet{
            DBService.manager.getClosestWhims(location: userLocation) { (whims) in
                self.feedWhims = whims
                self.delegate?.updateChildren(whims: whims)
            }
        }
    }
    
    // takes in Whims, updates local whim array
   public func update(withWhims: [Whim]) {
        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
            self.feedWhims = whims
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        
        
//        mapView.snp.makeConstraints { (make) in
//            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
//            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-200)
//            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.75)
//        }
        
        let mylocation = mapView.mapView.myLocation
        mapView.mapView.camera = GMSCameraPosition.camera(withLatitude: (mylocation?.coordinate.latitude)!,
                                                          longitude: (mylocation?.coordinate.longitude)!,
                                                          zoom: mapView.zoomLevel)
        mapView.mapView.settings.myLocationButton = true
        mapView.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MapVC: CLLocationManagerDelegate{
    
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        self.userLocation = location
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

