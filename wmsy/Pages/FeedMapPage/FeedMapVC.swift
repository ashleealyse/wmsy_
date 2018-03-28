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

    let toolBarHeightMultiplier: CGFloat = 0.16
    
    var feedView = FeedView()
    var containerView = UIView()
    var mapView = MapView()
    var filtersView = FiltersView()
    
    var guestProfile = GuestProfileVC()
    var expandedRows = Set<Int>()
//<<<<<<< HEAD
//
//    var currentUser : AppUser?
//
//
//    var feedVC = FeedVC()
//    var mapVC = MapVC()
//    var filtersVC = FiltersVC()
    
    
//=======
    var interestButtonCounter = 0

    var currentUser = AppUser.currentAppUser
    
    var currentUsersInterests = Set<String>() {
        didSet {
            print("Current User Interests: \(currentUsersInterests.count)")
        }
    }
    
    var locationManager = CLLocationManager()
    
    
    
    let categoryList = categoryTuples
    var userLocation = CLLocation(){
        didSet{
            print("userLocation set")
            DBService.manager.getClosestWhims(location: userLocation) { (whims) in
                self.feedWhims = whims
            }
        }
    }
    


//>>>>>>> qa
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
        currentUser = AppUser.currentAppUser
        if let currentUser = currentUser {
            print("current user: \(currentUser.name)")
            currentUsersInterests = Set(currentUser.interests.map{$0.whimID})
        }
        
        SVProgressHUD.dismiss()
        
        // setup container frame
        configureNavBar()
        
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
        
        filtersView.categoriesCV.delegate = self
        filtersView.categoriesCV.dataSource = self
        filtersView.categoriesCV.reloadData()
        filtersView.clearSearchButton.addTarget(self, action: #selector(clearSearch), for: .touchUpInside)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let height = view.safeAreaLayoutGuide.layoutFrame.height
        let width = view.safeAreaLayoutGuide.layoutFrame.width
        let x = view.frame.origin.x
        let y = height - (height * toolBarHeightMultiplier)
        let startingContainerFrame = CGRect(x: x, y: y, width: width, height: height)
        containerView = UIView.init(frame: startingContainerFrame)
        
        view.addSubview(feedView)
        view.addSubview(containerView)
        containerView.addSubview(filtersView)
        containerView.addSubview(mapView)
        feedView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(1 - toolBarHeightMultiplier)
        }
        
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        feedView.tableView.rowHeight = UITableViewAutomaticDimension
        feedView.tableView.separatorStyle = .none
        
        filtersView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(containerView)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(toolBarHeightMultiplier)
        }
        
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(filtersView.snp.bottom)
            make.leading.trailing.bottom.equalTo(containerView)
        }
        super.viewDidAppear(animated)
    }
    
    
    // setup UIBarButtonItems
    private func configureNavBar() {
        navigationItem.title = "wmsy"
        
        let topLeftBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(hostAWhim))
        navigationItem.leftBarButtonItem = topLeftBarItem
        
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mapIcon"), style: .plain, target: self, action: #selector(toggleMap))
        navigationItem.rightBarButtonItem = topRightBarItem
        
    }
    
    
    @objc func hostAWhim() {
        navigationController?.pushViewController(CreateWhimTVC(), animated: true)
    }
    
    @objc func toggleMap() {
//        filtersView.isHidden = false
//        mapView.isHidden = false
        let height = view.safeAreaLayoutGuide.layoutFrame.height
        let y = height - (height * toolBarHeightMultiplier)
        containerView.frame.size.height = height
        if navigationItem.rightBarButtonItem?.image == #imageLiteral(resourceName: "feedIcon") {
            containerView.frame.origin.y = feedView.frame.origin.y
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "mapIcon")
        } else {
            containerView.frame.origin.y = y
            navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "feedIcon")
        }
        print(view.safeAreaLayoutGuide.layoutFrame.height)
        print(containerView.frame.height)
    }

    @objc func clearSearch() {
        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
            self.feedWhims = whims
        }
        self.expandedRows = Set<Int>()
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
//}

//extension FeedMapVC: CLLocationManagerDelegate{
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

//extension FeedMapVC: mapDetailViewDelegate {
//    func interestPressed() {
//        print("interest is being pressed")
//    }
//
//    func userPicturePressed() {
//        present(GuestProfileVC(), animated: true, completion: nil)
//    }
//}


//extension FeedMapVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! WhimCategoryCollectionViewCell
//        let tuple = categoryList[indexPath.row]
//        var selectedCategory = tuple
//        self.filtersView.categoryLabel.text = "Filter Whims by: \(selectedCategory.0)"
//        DBService.manager.getCategoryWhims(fromCategory: selectedCategory.0) { (whims) in
//            self.feedWhims = whims
//        }
//    }
//}
//
//extension FeedMapVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categoryList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCell", for: indexPath) as! WhimCategoryCollectionViewCell
//        let categoryImage = categoryList[indexPath.row].1
//        cell.categoryImage.image = categoryImage
//        return cell
//    }
//}



