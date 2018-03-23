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

class FeedMapVC: MenuedViewController {
    
    var feedView = FeedView()
    var mapView = MapView()
    var expandedRows = Set<Int>()
    
    var feedWhims: [Whim] = [] {
        didSet {
            feedWhims = feedWhims.sortedByTimestamp()
            feedView.tableView.reloadData()
            mapView.mapView.clear()
            for whim in feedWhims{
                let position = CLLocationCoordinate2D(latitude: Double(whim.lat)!, longitude: Double(whim.long)!)
                let marker = GMSMarker(position: position)
                marker.title = whim.title
                marker.snippet = whim.description
                marker.map = mapView.mapView
            }
        }
    }
    
 
    var locationManager = CLLocationManager()
    var userLocation = CLLocation (){
        didSet{
            DBService.manager.getClosestWhims(location: userLocation) { (whims) in
                self.feedWhims = whims
            }
        }
    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        self.locationManager.stopUpdatingLocation()
//        self.mapView.mapView.isMyLocationEnabled = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        self.locationManager.delegate = self



//        view.addSubview(mapView)
//        let mylocation = mapView.mapView.myLocation
//        mapView.mapView.camera = GMSCameraPosition.camera(withLatitude: (mylocation?.coordinate.latitude)!,
//                                                          longitude: (mylocation?.coordinate.longitude)!,
//                                                          zoom: mapView.zoomLevel)
//        mapView.mapView.settings.myLocationButton = true
//        mapView.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        
        
        

        view.addSubview(feedView)


        feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        feedView.tableView.register(FeedCell.self, forCellReuseIdentifier: "WhimFeedCell")
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        feedView.tableView.rowHeight = UITableViewAutomaticDimension
        feedView.tableView.estimatedRowHeight = 90
        feedView.tableView.separatorStyle = .none

        configureNavBar()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        feedView.tableView.reloadData()
    }
    
    // setup UIBarButtonItem
    private func configureNavBar() {
        //        navigationItem.title = "wmsy"
        // top left bar button item to Host a Whim (popsicles with a + symbol?)
        let topLeftBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(hostAWhim))
        navigationItem.leftBarButtonItem = topLeftBarItem

        navigationItem.title = "wmsy"


        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "wmsyCategoryIcon"), style: .plain, target: self, action: #selector(hostAChat))
        navigationItem.rightBarButtonItem = topRightBarItem
        

    }
    
    @objc func hostAWhim() {
        
//        let createWhimTVC = CreateWhimTVC()
//        createWhimTVC.modalTransitionStyle = .coverVertical
//        createWhimTVC.modalPresentationStyle = .currentContext
//        navigationController?.present(createWhimTVC, animated: true, completion: nil)
        
        navigationController?.pushViewController(CreateWhimTVC(), animated: true)
    }
    


    @objc func hostAChat() {
        navigationController?.pushViewController(ChatRoomVC(), animated: true)
        
        print("temporary testing link for WhimChat")
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

extension FeedMapVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else {
                return
        }
        
        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        default:
            self.expandedRows.insert(indexPath.row)
        }
        
        cell.isExpanded = !cell.isExpanded
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension FeedMapVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedWhims.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell
        
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        let whim = feedWhims[indexPath.row]
        cell.collapsedView.postTitleLabel.text = whim.title
        cell.collapsedView.categoryIcon.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
        print(whim.hostImageURL)
        cell.collapsedView.userImageButton.imageView?.kf.setImage(with: URL(string: whim.hostImageURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            cell.collapsedView.userImageButton.setImage(image, for: .normal)
        })
        cell.expandedView.postDescriptionTF.text = whim.description
        return cell

    }
}

extension FeedMapVC: CLLocationManagerDelegate{
    
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        self.userLocation = location
        
        
        
        
        
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
//                                              longitude: location.coordinate.longitude,
//                                              zoom: mapView.zoomLevel)
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

