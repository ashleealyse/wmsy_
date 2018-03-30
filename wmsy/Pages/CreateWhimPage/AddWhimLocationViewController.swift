//
//  AddWhimLocationViewController.swift
//  wmsy
//
//  Created by C4Q on 3/21/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps

protocol setAddressDelegate: class {
    func setAddress(atAddress: String)
    func setCoordinates(long: String,lat: String)
}

class AddWhimLocationViewController: UIViewController {

    weak var delegate: setAddressDelegate?
    var addWhimLocationView = AddWhimLocationView()
    var selectedLocation: String = "" {
        didSet {
            addWhimLocationView.locationLabel.text = "\(selectedLocation)"
            addWhimLocationView.locationLabel.textColor = Stylesheet.Colors.WMSYKSUPurple
        }
    }
    var lat = ""
    var long = ""
    
    override func viewDidAppear(_ animated: Bool) {
        print("test")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addWhimLocationView.locationManager.delegate = self
        addWhimLocationView.addWhimMap.delegate = self
      
        addWhimLocationView.addWhimMap.settings.myLocationButton = true
        addWhimLocationView.addWhimMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addWhimLocationView.layer.cornerRadius = 10
        addWhimLocationView.layer.masksToBounds = true
        
        view.addSubview(addWhimLocationView)
        
        addWhimLocationView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)

        }
        
        
            
            
        addWhimLocationView.selectButton.addTarget(self, action: #selector(selectLocation), for: .touchUpInside)
        
        configureNavBar()
        
    }
    
    @objc func selectLocation() {
        // replace this with the pin point location from map
        print("Location Selected: \(selectedLocation)")
        
        delegate?.setAddress(atAddress: selectedLocation)
        delegate?.setCoordinates(long: long, lat: lat)
        // take the selectedLocation and bring it to the CreateWhimTVC
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureNavBar() {
        navigationItem.title = "Choose Whim Location"
        
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




extension AddWhimLocationViewController: GMSMapViewDelegate{

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        self.long = coordinate.longitude.description
        self.lat = coordinate.latitude.description
        let geo = GMSGeocoder()
        geo.reverseGeocodeCoordinate(coordinate) { (response, error) in
            print(response?.firstResult()?.description)
            let address = (response?.firstResult()?.addressLine1())! + " " + (response?.firstResult()?.addressLine2())!
            self.selectedLocation = address
        }
        
        self.addWhimLocationView.addWhimMap.clear() // clearing Pin before adding new
        let marker = GMSMarker(position: coordinate)
        marker.icon = GMSMarker.markerImage(with: Stylesheet.Colors.WMSYDeepViolet)
        marker.map = self.addWhimLocationView.addWhimMap
        
    }
    
}

extension AddWhimLocationViewController: CLLocationManagerDelegate{
    
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                      longitude: location.coordinate.longitude,
                                                      zoom: 13.0)
        self.addWhimLocationView.addWhimMap.camera = camera
        //
        //        if mapView.isHidden {
        //            mapView.isHidden = false
        //            self.mapView.mapView.camera = camera
        //        } else {
        //            self.mapView.mapView.animate(to: camera)
        //        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.addWhimLocationView.locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

