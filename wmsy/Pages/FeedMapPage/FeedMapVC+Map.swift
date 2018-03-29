//
//  FeedMapVC+Map.swift
//  wmsy
//
//  Created by C4Q on 3/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import SVProgressHUD

extension FeedMapVC: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let camera = GMSCameraPosition.camera(withLatitude: marker.position.latitude,
                                              longitude: marker.position.longitude,
                                              zoom: 15.0)
        self.mapView.mapView.animate(to: camera)
        let dict = marker.userData as? [String: String]
        self.mapView.detailView.whimTitle.text = dict!["title"]
        self.mapView.detailView.whimDescription.text = dict!["description"]
        let hostURL = URL(string: dict!["hostImageURL"]!)
        let hostID = dict!["hostID"]
        let whimID = dict!["whimID"]
        DBService.manager.getAppUser(fromID: hostID!) { (appUser) in
            self.currentUser = appUser
        }
        self.mapView.detailView.userPicture.kf.setImage(with: hostURL, for: .normal)
        let interests = getInterestKeys(appUser: AppUser.currentAppUser!)
        if interests.contains(whimID!){
            self.mapView.detailView.interestedButton.setImage(#imageLiteral(resourceName: "interestedCircleIcon"), for: .normal)
        }else{
            self.mapView.detailView.interestedButton.setImage(#imageLiteral(resourceName: "uninterestedCircleIcon"), for: .normal)
        }
        
        
        self.mapView.detailView.isHidden = false

        return true
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.mapView.detailView.isHidden = true
    }
}

extension FeedMapVC: CLLocationManagerDelegate{
    
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

extension FeedMapVC: mapDetailViewDelegate {
    func interestPressed() {
        print("interest is being pressed")
    }
    
    func userPicturePressed() {
        present(GuestProfileVC(), animated: true, completion: nil)
    }
}
