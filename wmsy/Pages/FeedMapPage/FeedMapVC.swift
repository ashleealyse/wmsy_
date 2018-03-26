//
//  FeedMapVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import SVProgressHUD

//protocol ParentDelegate: class {
//    func updateChildren(whims: [Whim]) -> Void
//}

class FeedMapVC: MenuedViewController, setFiltersVCDelegate {
    

//    var feedView = FeedView()
//    var mapView = MapView()
    var expandedRows = Set<Int>()
    var currentUser : AppUser?

    var feedVC = FeedVC()
    var mapVC = MapVC()
    var filtersVC = FiltersVC()
    
    var feedWhims: [Whim] = [] {
        didSet {
            print("number of whims to load: \(feedWhims.count)")
            feedWhims = feedWhims.sortedByTimestamp()
            feedVC.feedView.tableView.reloadData()
            mapVC.mapView.mapView.clear()
            for whim in feedWhims{
                let position = CLLocationCoordinate2D(latitude: Double(whim.lat)!, longitude: Double(whim.long)!)
                let marker = GMSMarker(position: position)
                marker.userData = ["title": whim.title,
                                   "description": whim.description,
                                   "hostImageURL": whim.hostImageURL,
                                   "category": whim.category,
                                   "hostID" : whim.hostID
                ]
                marker.map = mapVC.mapView.mapView
            }
        }
    }
    
    func changeListOf(whims: [Whim]) {
        self.feedWhims = whims
        print("filtered whims: \(whims)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(feedVC)
        add(filtersVC)
        add(mapVC)
        
        
        SVProgressHUD.dismiss()


        
        feedVC.delegate = self
        mapVC.delegate = self
        filtersVC.delegate = self
        
        view.addSubview(feedVC.feedView)
        feedVC.feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        
                view.addSubview(filtersVC.filtersView)
        filtersVC.filtersView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            //            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            //            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-200)
            //                        make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            //            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.16)
        }
        
                view.addSubview(mapVC.mapView)
        mapVC.mapView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(filtersVC.filtersView.snp.bottom)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.84)
        }
        
        
        
        
        configureNavBar()
        filtersVC.filtersView.isHidden = true
        mapVC.mapView.isHidden = true
        
        
    }
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        feedVC.feedView.tableView.reloadData()
    //    }
    
    // setup UIBarButtonItem
    private func configureNavBar() {
        navigationItem.title = "wmsy"
        
        let topLeftBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(hostAWhim))
        navigationItem.leftBarButtonItem = topLeftBarItem
        
        
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mapIcon"), style: .plain, target: self, action: #selector(showMap))
        
        let altTopRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "feedIcon"), style: .plain, target: self, action: #selector(hideMap))
        
        navigationItem.rightBarButtonItem = topRightBarItem
        
        
    }
    
    
    @objc func hostAWhim() {
        navigationController?.pushViewController(CreateWhimTVC(), animated: true)
    }
    
    //    @objc func hostAChat() {
    //        navigationController?.pushViewController(ChatRoomVC(), animated: true)
    //        print("temporary testing link for WhimChat")
    //    }
    
    @objc func showMap() {
        filtersVC.filtersView.isHidden = false
        mapVC.mapView.isHidden = false
        let altTopRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "feedIcon"), style: .plain, target: self, action: #selector(hideMap))
        self.navigationItem.rightBarButtonItem = altTopRightBarItem
    }
    
    @objc func hideMap() {
        filtersVC.filtersView.isHidden = true
        mapVC.mapView.isHidden = true
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mapIcon"), style: .plain, target: self, action: #selector(showMap))
        navigationItem.rightBarButtonItem = topRightBarItem
    }
}



//extension FeedMapVC: GMSMapViewDelegate{
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        let camera = GMSCameraPosition.camera(withLatitude: marker.position.latitude,
//                                             longitude: marker.position.longitude,
//                                             zoom: 15.0)
//        self.mapView.mapView.animate(to: camera)
//        let dict = marker.userData as? [String: String]
//        self.mapView.detailView.whimTitle.text = dict!["title"]
//        self.mapView.detailView.whimDescription.text = dict!["description"]
//        let hostURL = URL(string: dict!["hostImageURL"]!)
//        let hostID = dict!["hostID"]
//        DBService.manager.getAppUser(with: hostID!) { (appUser) in
//           self.currentUser = appUser
//        }
//        self.mapView.detailView.userPicture.kf.setImage(with: hostURL, for: .normal)
//        self.mapView.detailView.isHidden = false
//
//        return true
//    }
//
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        self.mapView.detailView.isHidden = true
//    }
//
//}
//
//extension FeedMapVC: CLLocationManagerDelegate{
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

//extension FeedMapVC: ParentDelegate {
//    func updateChildren(whims: [Whim]) {
//        self.feedWhims = whims
//
//    }
//}

//extension FeedMapVC: mapDetailViewDelegate {
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

