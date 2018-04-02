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
    
    let toolBarHeight: CGFloat = 90.0
    var verticalPinConstraint: Constraint? = nil
    var feedView = FeedView()
    var mapView = MapView()
    var filtersView = FiltersView()
    var filterMapContainerView = UIView()
    var mapUp: Bool = false
    
    var guestProfile = GuestProfileVC()
    var expandedRows = Set<Int>()
    var interestButtonCounter = 0
    var currentWhim: Whim?
    
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
                self.feedWhims = whims.filter(){$0.finalized != true}
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
                                   "hostID" : whim.hostID,
                                   "whimID": whim.id
                ]
                marker.icon = GMSMarker.markerImage(with: Stylesheet.Colors.WMSYDeepViolet)
                marker.map = mapView.mapView
            }
        }
    }
    
    
    @objc func refreshData(refreshControl: UIRefreshControl){
        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
            self.feedWhims = whims.filter(){$0.finalized != true}
            self.feedView.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedView.tableView.separatorStyle = .singleLine
        self.feedView.tableView.separatorColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.5)
        self.feedView.tableView.separatorInset.right = 10
        self.feedView.tableView.separatorInset.left = 10

        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: Stylesheet.Colors.WMSYDeepViolet)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.feedView.tableView.refreshControl = refreshControl
        currentUser = AppUser.currentAppUser
        if let currentUser = currentUser {
            print("current user: \(currentUser.name)")
            currentUsersInterests = Set(currentUser.interests.map{$0.whimID})
        }
        
        SVProgressHUD.dismiss()

        configureNavBar()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        
        layoutFeedMapView()
        layoutfilterMapContainer()
        layoutFiltersView()
        layoutMapView()
        addPanGesture(view: filterMapContainerView)
        self.mapView.detailView.isHidden = true
        self.mapView.mapView.delegate = self
        self.mapView.detailView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MenuNotificationTracker.manager.delegate = MenuData.manager
    }
    

    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(FeedMapVC.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let filterMapContainerView = sender.view!
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        switch sender.state {
        case .began, .changed:
            //Check to make sure new center is within bounds
            filterMapContainerView.center = CGPoint(x: view.center.x, y: filterMapContainerView.center.y + translation.y)
                sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if filterMapContainerView.frame.minY > feedView.frame.maxY {
                print(filterMapContainerView.frame.minY)
                print(feedView.frame.maxY)
                verticalPinConstraint?.deactivate()
                self.mapUp = false
                self.pinFilterViewToBottom()
//                UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
//                })
            }
            if filterMapContainerView.frame.minY <= CGFloat(368) || velocity.y < -300 {
                verticalPinConstraint?.deactivate()
                self.mapUp = !self.mapUp
                self.pinFilterViewToTop()
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            if velocity.y > 300 {
                verticalPinConstraint?.deactivate()
                self.pinFilterViewToBottom()
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        default:
            break
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("removing live feed updates")
//        DBService.manager.whimsRef.removeAllObservers()
    }
    
    
    func layoutFeedMapView() {
        view.addSubview(feedView)

        feedView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(toolBarHeight)
        }
        feedView.tableView.dataSource = self
        feedView.tableView.delegate = self
        feedView.tableView.rowHeight = UITableViewAutomaticDimension
    }
    func layoutfilterMapContainer() {
        view.addSubview(filterMapContainerView)
        filterMapContainerView.snp.makeConstraints { (make) in
//            make.height.equalTo(view.safeAreaLayoutGuide.snp.height)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            verticalPinConstraint = make.top.equalTo(feedView.snp.bottom).constraint
        }
    }
    func layoutFiltersView() {
        filterMapContainerView.addSubview(filtersView)
        filtersView.snp.makeConstraints { (make) in
            make.height.equalTo(toolBarHeight)
            make.leading.equalTo(filterMapContainerView.snp.leading)
            make.trailing.equalTo(filterMapContainerView.snp.trailing)
            make.top.equalTo(filterMapContainerView.snp.top)
        }
        filtersView.categoriesCV.delegate = self
        filtersView.categoriesCV.dataSource = self
        filtersView.categoriesCV.reloadData()
        filtersView.clearSearchButton.addTarget(self, action: #selector(clearSearch), for: .touchUpInside)

    }
    
    func layoutMapView() {
        filterMapContainerView.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(filtersView.snp.bottom)
            make.leading.equalTo(filterMapContainerView.snp.leading)
            make.trailing.equalTo(filterMapContainerView.snp.trailing)
            make.height.equalTo(feedView)
            make.bottom.equalTo(filterMapContainerView.snp.bottom)
        }

        let mylocation = mapView.mapView.myLocation
        mapView.mapView.camera = GMSCameraPosition.camera(withLatitude: (mylocation?.coordinate.latitude)!,
                                                          longitude: (mylocation?.coordinate.longitude)!,
                                                          zoom: mapView.zoomLevel)
        mapView.mapView.settings.myLocationButton = true
        mapView.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }
    
    
    
    // setup UIBarButtonItems
    private func configureNavBar() {
        navigationItem.title = "wmsy"
        let topLeftBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addIcon"), style: .plain, target: self, action: #selector(hostAWhim))
        topLeftBarItem.tintColor = Stylesheet.Colors.WMSYKSUPurple
        navigationItem.leftBarButtonItem = topLeftBarItem
        
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mapIcon"), style: .plain, target: self, action: #selector(toggleMap))
        topRightBarItem.tintColor = Stylesheet.Colors.WMSYKSUPurple
        navigationItem.rightBarButtonItem = topRightBarItem
        
        
    }
    
    
    @objc func hostAWhim() {
        navigationController?.pushViewController(CreateWhimTVC(), animated: false)
        
        navigationController?.isToolbarHidden = true
        print("Show Whim Host User Profile")
//        CreateWhimTVC().modalPresentationStyle = .none
//        self.present(CreateWhimTVC(), animated: false, completion: nil)
    }
    
    func pinFilterViewToBottom() {
        filterMapContainerView.snp.makeConstraints { (make) in
            verticalPinConstraint = make.top.equalTo(feedView.snp.bottom).constraint
        }
    }
    
    func pinFilterViewToTop() {
        filterMapContainerView.snp.makeConstraints { (make) in
            verticalPinConstraint = make.top.equalTo(view.safeAreaLayoutGuide.snp.top).constraint
        }
    }
    
    @objc func toggleMap(sender: UIBarButtonItem) {
        sender.isEnabled = false
        verticalPinConstraint?.deactivate()
        
        if mapUp {
            pinFilterViewToBottom()
            self.mapView.detailView.isHidden = true
        } else {
            pinFilterViewToTop()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.mapUp = !self.mapUp
            sender.isEnabled = true
        })
    }
    
    @objc func clearSearch() {
        DBService.manager.getClosestWhims(location: userLocation) { (whims) in
            self.feedWhims = whims
//            for i in 0...5 {
//                let indexPath = IndexPath.init(row: i, section: 0)
//                print(i)
//                let cell = self.filtersView.categoriesCV.cellForItem(at: indexPath) as! WhimCategoryCollectionViewCell
//                cell.isSelected = false
//
//            }
        }
        self.expandedRows = Set<Int>()
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

