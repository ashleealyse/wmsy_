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

protocol ParentDelegate: class {
    func updateChildren(whims: [Whim]) -> Void
}

class FeedMapVC: MenuedViewController {
    
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
                marker.title = whim.title
                marker.snippet = whim.description
                marker.map = mapVC.mapView.mapView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(feedVC)
        add(filtersVC)
        add(mapVC)
        
        
        SVProgressHUD.dismiss()

//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
//        self.locationManager.delegate = self

//        view.addSubview(mapView)
//        let mylocation = mapView.mapView.myLocation
//        mapView.mapView.camera = GMSCameraPosition.camera(withLatitude: (mylocation?.coordinate.latitude)!,
//                                                          longitude: (mylocation?.coordinate.longitude)!,
//                                                          zoom: mapView.zoomLevel)
//        mapView.mapView.settings.myLocationButton = true
//        mapView.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        
        feedVC.delegate = self
        mapVC.delegate = self
        
        
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




extension FeedMapVC: ParentDelegate {
    func updateChildren(whims: [Whim]) {
        self.feedWhims = whims
    }
}
