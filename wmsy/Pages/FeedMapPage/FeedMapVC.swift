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

class FeedMapVC: MenuedViewController {
    
    var feedView = FeedView()
    var mapView = MapView()
    var filtersView = FiltersView()
    
    var expandedRows = Set<Int>()
    var currentUser : AppUser?
    
    var locationManager = CLLocationManager()
    
    let categoryList = categoryTuples
    var userLocation = CLLocation(){
        didSet{
            print("userLocation set")
            DBService.manager.getClosestWhims(location: userLocation) { (whims) in
                self.feedWhims = whims
                //                self.delegate?.updateChildren(whims: whims)
            }
        }
    }
    

    
    var feedWhims: [Whim] = [] {
        didSet {
            print("number of whims to load: \(feedWhims.count)")
            feedWhims = feedWhims.sortedByTimestamp()
            feedView.tableView.reloadData()
            mapView.mapView.clear()
            for whim in feedWhims{
                let position = CLLocationCoordinate2D(latitude: Double(whim.lat)!, longitude: Double(whim.long)!)
                let marker = GMSMarker(position: position)
                marker.userData = ["title": whim.title,
                                   "description": whim.description,
                                   "hostImageURL": whim.hostImageURL,
                                   "category": whim.category,
                                   "hostID" : whim.hostID
                ]
                marker.map = mapView.mapView
            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        
        filtersView.isHidden = true
        mapView.isHidden = true
        
        filtersView.categoriesCV.delegate = self
        filtersView.categoriesCV.dataSource = self
        filtersView.categoriesCV.reloadData()
        filtersView.clearSearchButton.addTarget(self, action: #selector(clearSearch), for: .touchUpInside)
        
        let mylocation = mapView.mapView.myLocation
        mapView.mapView.camera = GMSCameraPosition.camera(withLatitude: (mylocation?.coordinate.latitude)!,
                                                          longitude: (mylocation?.coordinate.longitude)!,
                                                          zoom: mapView.zoomLevel)
        mapView.mapView.settings.myLocationButton = true
        mapView.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        self.locationManager.delegate = self

        
        view.addSubview(feedView)
        feedView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        feedView.tableView.rowHeight = UITableViewAutomaticDimension
        feedView.tableView.estimatedRowHeight = 90
        feedView.tableView.separatorStyle = .none
        
        view.addSubview(filtersView)
        filtersView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            //            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            //            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-200)
            //                        make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            //            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.16)
        }
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(filtersView.snp.bottom)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.84)
        }
        
        

        configureNavBar()

    }
    
    
    
    // setup UIBarButtonItems
    private func configureNavBar() {
        navigationItem.title = "wmsy"
        
        let topLeftBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(hostAWhim))
        navigationItem.leftBarButtonItem = topLeftBarItem
        
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mapIcon"), style: .plain, target: self, action: #selector(showMap))
        let altTopRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "feedIcon"), style: .plain, target: self, action: #selector(hideMap))
        navigationItem.rightBarButtonItem = topRightBarItem
        
    }
    
    @objc func clearSearch() {
        print("need to add functionality to clear the search category")
    }
    
    @objc func hostAWhim() {
        navigationController?.pushViewController(CreateWhimTVC(), animated: true)
    }
    
    @objc func showMap() {
        filtersView.isHidden = false
        mapView.isHidden = false
        let altTopRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "feedIcon"), style: .plain, target: self, action: #selector(hideMap))
        self.navigationItem.rightBarButtonItem = altTopRightBarItem
    }
    
    @objc func hideMap() {
        filtersView.isHidden = true
        mapView.isHidden = true
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mapIcon"), style: .plain, target: self, action: #selector(showMap))
        navigationItem.rightBarButtonItem = topRightBarItem
    }
}



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
        DBService.manager.getAppUser(with: hostID!) { (appUser) in
           self.currentUser = appUser
        }
        self.mapView.detailView.userPicture.kf.setImage(with: hostURL, for: .normal)
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



//extension FeedMapVC: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? FeedCell else {
//            return
//        }
//        
//        //        switch cell.isExpanded {
//        //        case true:
//        //            self.expandedRows.remove(indexPath.row)
//        //        default:
//        //            self.expandedRows.insert(indexPath.row)
//        //        }
//        //
//        cell.isExpanded = !cell.isExpanded
//        
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//}
//
//extension FeedMapVC: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return feedWhims.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WhimFeedCell", for: indexPath) as! FeedCell
//        
//        cell.isExpanded = self.expandedRows.contains(indexPath.row)
//        let whim = feedWhims[indexPath.row]
//        cell.collapsedView.postTitleLabel.text = whim.title
//        cell.collapsedView.categoryIcon.image = UIImage(named: "\(whim.category.lowercased())CategoryIcon")
//        cell.collapsedView.userImageButton.imageView?.kf.setImage(with: URL(string: whim.hostImageURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
//            cell.collapsedView.userImageButton.setImage(image, for: .normal)
//        })
//        cell.expandedView.postDescriptionTF.text = whim.description
//        return cell
//        
//    }
//}

extension FeedMapVC: mapDetailViewDelegate {
    func interestPressed() {
        print("interest is being pressed")
    }
    
    func userPicturePressed() {
        present(GuestProfileVC(), animated: true, completion: nil)
    }
    
    
}


extension FeedMapVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WhimCategoryCollectionViewCell
        let tuple = categoryList[indexPath.row]
        var selectedCategory = tuple
        self.filtersView.categoryLabel.text = "Filter Whims by: \(selectedCategory.0)"
        DBService.manager.getCategoryWhims(fromCategory: selectedCategory.0) { (whims) in
            self.feedWhims = whims
        }
    }
}

extension FeedMapVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCell", for: indexPath) as! WhimCategoryCollectionViewCell
        let categoryImage = categoryList[indexPath.row].1
        cell.categoryImage.image = categoryImage
        return cell
    }
}



