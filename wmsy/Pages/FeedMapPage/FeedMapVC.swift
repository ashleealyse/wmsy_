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
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(FeedMapVC.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let filterMapContainerView = sender.view!
        let translation = sender.translation(in: view)
//        let velocity = sender.velocity(in: view)
        switch sender.state {
        case .began, .changed:
//            verticalPinConstraint?.deactivate()
            filterMapContainerView.center = CGPoint(x: view.center.x, y: filterMapContainerView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            print("\(filterMapContainerView.center.x), \(filterMapContainerView.center.y)")
//            print(velocity)
        case .ended:
            if filterMapContainerView.frame.origin.y <= CGFloat(375) {
                verticalPinConstraint?.deactivate()
                self.mapUp = !self.mapUp
                self.pinFilterViewToTop()
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            } else {
                verticalPinConstraint?.deactivate()
                self.pinFilterViewToBottom()
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        default:
            break
        }
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
        feedView.tableView.separatorStyle = .none
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
        navigationItem.leftBarButtonItem = topLeftBarItem
        
        let topRightBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mapIcon"), style: .plain, target: self, action: #selector(toggleMap))
        navigationItem.rightBarButtonItem = topRightBarItem
        
    }
    
    
    @objc func hostAWhim() {
        navigationController?.pushViewController(CreateWhimTVC(), animated: true)
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
        }
        self.expandedRows = Set<Int>()
    }
}
